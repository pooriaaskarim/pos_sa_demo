import 'package:flutter/material.dart';

import 'app.theme_data.dart';
import 'components_theme/app.dialog_theme_data.dart';
import 'components_theme/app.elevated_button_theme_data.dart';
import 'components_theme/app.icon_button_theme_data.dart';
import 'components_theme/app.snack_bar_theme_data.dart';
import 'components_theme/app.text_button_theme_data.dart';

class AppThemes {
  AppThemes._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppThemeData.lightColorScheme,
    dialogTheme: AppDialogThemeData(AppThemeData.lightColorScheme),
    elevatedButtonTheme: AppElevatedButtonThemeData.from(
      AppThemeData.lightColorScheme,
    ),
    iconButtonTheme: AppIconButtonThemeData.from(AppThemeData.lightColorScheme),
    primaryColorDark: AppThemeData.darkColorScheme.primary,
    primaryColorLight: AppThemeData.lightColorScheme.primary,
    scaffoldBackgroundColor: AppThemeData.lightColorScheme.background,
    snackBarTheme: const AppSnackBarThemeData(),
    textButtonTheme: AppTextButtonThemeData(AppThemeData.lightColorScheme),
    textTheme: AppThemeData.textTheme,
    useMaterial3: true,
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppThemeData.darkColorScheme,
    dialogTheme: AppDialogThemeData(AppThemeData.darkColorScheme),
    elevatedButtonTheme: AppElevatedButtonThemeData.from(
      AppThemeData.darkColorScheme,
    ),
    iconButtonTheme: AppIconButtonThemeData.from(AppThemeData.darkColorScheme),
    primaryColor: AppThemeData.darkColorScheme.primary,
    primaryColorDark: AppThemeData.darkColorScheme.primary,
    primaryColorLight: AppThemeData.lightColorScheme.primary,
    scaffoldBackgroundColor: AppThemeData.darkColorScheme.background,
    snackBarTheme: const AppSnackBarThemeData(),
    textButtonTheme: AppTextButtonThemeData(AppThemeData.darkColorScheme),
    textTheme: AppThemeData.textTheme,
    useMaterial3: true,
  );
}
