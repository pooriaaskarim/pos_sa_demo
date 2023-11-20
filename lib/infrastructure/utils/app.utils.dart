import 'package:flutter/material.dart';

import 'app.responsive_utils.dart';
import 'app.sizes.dart';

class AppUtils {
  AppUtils._();

  static const double borderRadius = 5.0;

  /// Relative path to where Image Assets reside
  static const String imageAssetsPath = 'assets/images/';

  ///returns a SizedBox of height [size] with a default of AppSizes.points_16
  static Widget verticalSpacer([final double size = AppSizes.points_16]) =>
      SizedBox(
        height: size,
      );

  ///returns a SizedBox of width [size] with a default of AppSizes.points_16
  static Widget horizontalSpacer([final double size = AppSizes.points_16]) =>
      SizedBox(
        width: size,
      );

  static void rebuildDescendantChildren(final BuildContext context) {
    void rebuild(final Element el) {
      el
        ..markNeedsBuild()
        ..visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static Future<void> fakeDelay([
    final Duration duration = const Duration(seconds: 1),
  ]) async {
    await Future.delayed(duration);
  }

  static Widget get emptyWidget => const SizedBox.shrink();

  static bool _startsWithRtl(final String text) {
    const String ltrChars =
        r'A-Za-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02B8\u0300-\u0590'
        r'\u0800-\u1FFF\u2C00-\uFB1C\uFDFE-\uFE6F\uFEFD-\uFFFF';
    const String rtlChars = r'\u0591-\u07FF\uFB1D-\uFDFD\uFE70-\uFEFC';
    return RegExp('^[^$ltrChars]*[$rtlChars]').hasMatch(text);
  }

  static TextDirection estimateDirectionOfText(
    final String text,
  ) {
    final words = text.split(RegExp(r'\s+'));
    if (_startsWithRtl(words.first)) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  static EdgeInsets responsiveHorizontalPadding(final BuildContext context) =>
      deviceType(context).horizontalPadding(context);

  static EdgeInsets responsiveVerticalPadding(final BuildContext context) =>
      deviceType(context).verticalPadding(context);

  static Device deviceType(final BuildContext context) =>
      Device.values.firstWhere(
        (final element) => element.screenRange.isInRange(context),
      );

  static Widget responsiveContent({
    required final Widget child,
    required final BuildContext context,
    final bool isScrollable = true,
    final Axis scrollDirection = Axis.vertical,
    final Alignment alignment = Alignment.center,
  }) {
    final paddedChild = Padding(
      padding: scrollDirection == Axis.vertical
          ? responsiveHorizontalPadding(context)
          : responsiveVerticalPadding(context),
      child: child,
    );
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: isScrollable
            ? SingleChildScrollView(
                physics: const PageScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                scrollDirection: scrollDirection,
                child: paddedChild,
              )
            : paddedChild,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}
