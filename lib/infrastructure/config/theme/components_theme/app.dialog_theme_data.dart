import 'package:flutter/material.dart';

import '../../../utils/app.utils.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';

class AppDialogThemeData extends DialogTheme {
  AppDialogThemeData(final ColorScheme colorScheme)
      : super(
          titleTextStyle: AppFonts.textTheme.headlineSmall?.merge(
            TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
          contentTextStyle: AppFonts.textTheme.bodyMedium?.merge(
            TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          alignment: AlignmentDirectional.center,
          backgroundColor: colorScheme.surface,
          elevation: AppElevations.level_0,
          iconColor: colorScheme.secondary,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppUtils.borderRadius)),
          ),
        );
}
