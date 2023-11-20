import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../../../utils/app.utils.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';
import '../app.opacities.dart';

class AppIconButtonThemeData extends IconButtonThemeData {
  AppIconButtonThemeData.from(
    final ColorScheme colorScheme,
  ) : super(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStateProperty.resolveWith<double?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return AppElevations.level_0;
                }
                if (states.any(
                  {
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return AppElevations.level_2;
                }
                //focused, pressed and enabled states
                return AppElevations.level_1;
              },
            ),
            shape: const MaterialStatePropertyAll(
              ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppUtils.borderRadius)),
              ),
            ),
            textStyle: MaterialStatePropertyAll(
              AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onBackground,
                  fontWeight: AppFonts.bold,
                ),
              ),
            ),
            iconColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.onBackground.withOpacity(38 / 100);
                }
                //Any State other than disabled
                return colorScheme.onBackground;
              },
            ),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            alignment: Alignment.center,
            minimumSize: const MaterialStatePropertyAll(
              Size(AppSizes.points_40, AppSizes.points_40),
            ),
            maximumSize: const MaterialStatePropertyAll(
              Size(AppSizes.points_40, AppSizes.points_40),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.standard,
          ),
        );

  static ButtonStyle outlineVariantStyle(final ColorScheme colorScheme) =>
      AppIconButtonThemeData.from(colorScheme).style!.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.outlineVariant;
            }
            if (states.any(
              {
                MaterialState.hovered,
              }.contains,
            )) {
              return colorScheme.outlineVariant
                  .withOpacity(AppOpacities.hoverStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.focused,
              }.contains,
            )) {
              return colorScheme.outlineVariant
                  .withOpacity(AppOpacities.focusStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.pressed,
              }.contains,
            )) {
              return colorScheme.outlineVariant
                  .withOpacity(AppOpacities.pressStateLayerOpacity);
            }
            //default: enabled state
            return colorScheme.outlineVariant;
          },
        ),
        // elevation: const MaterialStatePropertyAll(0),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.onSurface.withOpacity(38 / 100);
            }
            //Any State other than disabled
            return colorScheme.onSurface;
          },
        ),
      );

  static ButtonStyle tertiaryContainerStyle(final ColorScheme colorScheme) =>
      AppIconButtonThemeData.from(colorScheme).style!.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.outlineVariant
                  .withOpacity(AppOpacities.disabledStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.hovered,
              }.contains,
            )) {
              return colorScheme.tertiaryContainer
                  .withOpacity(AppOpacities.hoverStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.focused,
              }.contains,
            )) {
              return colorScheme.tertiaryContainer
                  .withOpacity(AppOpacities.focusStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.pressed,
              }.contains,
            )) {
              return colorScheme.tertiaryContainer
                  .withOpacity(AppOpacities.pressStateLayerOpacity);
            }
            //default: enabled state
            return colorScheme.tertiaryContainer;
          },
        ),
        // elevation: const MaterialStatePropertyAll(0),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.onSurface.withOpacity(38 / 100);
            }
            //Any State other than disabled
            return colorScheme.onSurface;
          },
        ),
      );

  static ButtonStyle errorStyle(final ColorScheme colorScheme) =>
      AppIconButtonThemeData.from(colorScheme).style!.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.errorContainer
                  .withOpacity(AppOpacities.disabledStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.hovered,
              }.contains,
            )) {
              return colorScheme.errorContainer
                  .withOpacity(AppOpacities.hoverStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.focused,
              }.contains,
            )) {
              return colorScheme.errorContainer
                  .withOpacity(AppOpacities.focusStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.pressed,
              }.contains,
            )) {
              return colorScheme.errorContainer
                  .withOpacity(AppOpacities.pressStateLayerOpacity);
            }
            //default: enabled state
            return colorScheme.errorContainer;
          },
        ),
        // elevation: const MaterialStatePropertyAll(0),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.error.withOpacity(38 / 100);
            }
            //Any State other than disabled
            return colorScheme.error;
          },
        ),
      );
}
