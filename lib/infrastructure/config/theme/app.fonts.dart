import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  /// Text Theme Data
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      height: 64 / 57,
      fontSize: 57,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      height: 52 / 45,
      fontSize: 45,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      height: 44 / 36,
      fontSize: 36,
      fontStyle: FontStyle.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      height: 40 / 32,
      fontSize: 32,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      height: 36 / 28,
      fontSize: 28,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      height: 32 / 24,
      fontSize: 24,
      fontStyle: FontStyle.normal,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      height: 24 / 18,
      fontSize: 18,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      height: 24 / 16,
      fontSize: 16,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      height: 20 / 14,
      fontSize: 14,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      height: 24 / 16,
      fontSize: 16,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      height: 20 / 14,
      fontSize: 14,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      height: 16 / 12,
      fontSize: 12,
      fontStyle: FontStyle.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      height: 20 / 14,
      fontSize: 14,
      fontStyle: FontStyle.normal,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      height: 16 / 12,
      fontSize: 12,
      fontStyle: FontStyle.normal,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      height: 16 / 10,
      fontSize: 10,
      fontStyle: FontStyle.normal,
    ),
  );

  /// FontFamily
  static const String fontFamily = 'Roboto';

  ///Font Weight: thin
  static const FontWeight thin = FontWeight.w200;

  ///Font Weight: light
  static const FontWeight light = FontWeight.w300;

  ///Font Weight: normal
  static const FontWeight normal = FontWeight.w400;

  ///Font Weight: medium
  static const FontWeight medium = FontWeight.w500;

  ///Font Weight: bold
  static const FontWeight bold = FontWeight.w700;
}
