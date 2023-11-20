import 'package:flutter/material.dart';

import '../../../utils/app.sizes.dart';
import '../app.elevations.dart';
import '../app.fonts.dart';
import '../app.opacities.dart';

class AppElevatedButtonThemeData extends ElevatedButtonThemeData {
  AppElevatedButtonThemeData.from(
    final ColorScheme colorScheme,
  ) : super(
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                vertical: AppSizes.points_12,
                horizontal: AppSizes.points_16,
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.primary
                      .withOpacity(AppOpacities.disabledStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return colorScheme.primary
                      .withOpacity(AppOpacities.hoverStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.focused,
                  }.contains,
                )) {
                  return colorScheme.primary
                      .withOpacity(AppOpacities.focusStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.pressed,
                  }.contains,
                )) {
                  return colorScheme.primary
                      .withOpacity(AppOpacities.pressStateLayerOpacity);
                }
                //default: enabled state
                return colorScheme.primary;
              },
            ),
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            textStyle: MaterialStatePropertyAll(
              AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onPrimary,
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
                  return colorScheme.onPrimary.withOpacity(38 / 100);
                }
                //Any State other than disabled
                return colorScheme.onPrimary;
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith(
              (final states) => states.contains(MaterialState.pressed)
                  ? colorScheme.onPrimary.withOpacity(38 / 100)
                  : null,
            ),
            splashFactory: InkRipple.splashFactory,
          ),
        );

  static ButtonStyle tertiaryStyle(final ColorScheme colorScheme) =>
      AppElevatedButtonThemeData.from(colorScheme).style!.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.tertiary
                  .withOpacity(AppOpacities.disabledStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.hovered,
              }.contains,
            )) {
              return colorScheme.tertiary
                  .withOpacity(AppOpacities.hoverStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.focused,
              }.contains,
            )) {
              return colorScheme.tertiary
                  .withOpacity(AppOpacities.focusStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.pressed,
              }.contains,
            )) {
              return colorScheme.tertiary
                  .withOpacity(AppOpacities.pressStateLayerOpacity);
            }
            //default: enabled state
            return colorScheme.tertiary;
          },
        ),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.onTertiary.withOpacity(38 / 100);
            }
            //Any State other than disabled
            return colorScheme.onTertiary;
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onTertiaryContainer,
                  fontWeight: AppFonts.bold,
                ),
              );
            } else {
              return AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onTertiary,
                  fontWeight: AppFonts.bold,
                ),
              );
            }
          },
        ),
      );

  static ButtonStyle errorStyle(final ColorScheme colorScheme) =>
      AppElevatedButtonThemeData.from(colorScheme).style!.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.error
                  .withOpacity(AppOpacities.disabledStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.hovered,
              }.contains,
            )) {
              return colorScheme.error
                  .withOpacity(AppOpacities.hoverStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.focused,
              }.contains,
            )) {
              return colorScheme.error
                  .withOpacity(AppOpacities.focusStateLayerOpacity);
            }
            if (states.any(
              {
                MaterialState.pressed,
              }.contains,
            )) {
              return colorScheme.error
                  .withOpacity(AppOpacities.pressStateLayerOpacity);
            }
            //default: enabled state
            return colorScheme.error;
          },
        ),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return colorScheme.onError.withOpacity(38 / 100);
            }
            //Any State other than disabled
            return colorScheme.onError;
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (final states) {
            if (states.any(
              {
                MaterialState.disabled,
              }.contains,
            )) {
              return AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onError,
                  fontWeight: AppFonts.bold,
                ),
              );
            } else {
              return AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onError,
                  fontWeight: AppFonts.bold,
                ),
              );
            }
          },
        ),
      );

  static ButtonStyle primaryContainerStyle(final ColorScheme colorScheme) =>
      AppElevatedButtonThemeData.from(colorScheme).style!.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.primaryContainer
                      .withOpacity(AppOpacities.disabledStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.hovered,
                  }.contains,
                )) {
                  return colorScheme.primaryContainer
                      .withOpacity(AppOpacities.hoverStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.focused,
                  }.contains,
                )) {
                  return colorScheme.primaryContainer
                      .withOpacity(AppOpacities.focusStateLayerOpacity);
                }
                if (states.any(
                  {
                    MaterialState.pressed,
                  }.contains,
                )) {
                  return colorScheme.primaryContainer
                      .withOpacity(AppOpacities.pressStateLayerOpacity);
                }
                //default: enabled state
                return colorScheme.primaryContainer;
              },
            ),
            iconColor: MaterialStateProperty.resolveWith<Color?>(
              (final states) {
                if (states.any(
                  {
                    MaterialState.disabled,
                  }.contains,
                )) {
                  return colorScheme.onPrimaryContainer.withOpacity(38 / 100);
                }
                //Any State other than disabled
                return colorScheme.onPrimaryContainer;
              },
            ),
            textStyle: MaterialStatePropertyAll(
              AppFonts.textTheme.labelLarge?.merge(
                TextStyle(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: AppFonts.bold,
                ),
              ),
            ),
          );
}
