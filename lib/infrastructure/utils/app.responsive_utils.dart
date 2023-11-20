import 'package:flutter/material.dart';

enum Device { mobile, tablet, desktop, bigScreen }

extension ResponsiveExtension on Device {
  DeviceScreenWidthRange get screenRange {
    switch (this) {
      case Device.mobile:
        return DeviceScreenWidthRange(lowerBound: 0, upperBound: 480);
      case Device.tablet:
        return DeviceScreenWidthRange(lowerBound: 480, upperBound: 900);
      case Device.desktop:
        return DeviceScreenWidthRange(lowerBound: 900, upperBound: 1200);
      case Device.bigScreen:
        return DeviceScreenWidthRange(
          lowerBound: 1200,
        );
    }
  }

  bool isInRange(final BuildContext context) => screenRange.isInRange(context);

  EdgeInsets horizontalPadding(final BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: (width < 480)
          ? 0
          : (width >= 480 && width < 900)
              ? width / 6
              : (width >= 900 && width < 1200)
                  ? width / 7
                  : width / 8,
    );
  }

  EdgeInsets verticalPadding(final BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return EdgeInsets.symmetric(
      vertical: (height < 900)
          ? 0
          :
          // (height >= 480 && height < 900) ?
          height / 6
      // : (height >= 900 && height <= 1200)
      //     ? height / 4
      //     : height / 3
      ,
    );
  }
}

class DeviceScreenWidthRange {
  DeviceScreenWidthRange({this.lowerBound, this.upperBound});

  final double? lowerBound;
  final double? upperBound;

  bool isInRange(final BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width > (lowerBound ?? 0)) &&
        (upperBound == null || width < upperBound!);
  }
}
