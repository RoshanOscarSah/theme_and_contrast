import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../design_system/app_color_extension.dart';
import '../design_system/app_text_styles.dart';

ThemeData buildHighContrastDarkTheme() {
  final extensionColors = ExtensionColors(
    yellow500: AppColors.BLUE_300,
    brown500: AppColors.BLUE_300,
    emerald500: AppColors.BLUE_300,
    backgroundPrimary: AppColors.BACKGROUND_APP,
    red500: AppColors.BLUE_300,
  );
  TextTheme buildHighContrastDarkTextTheme() {
    return TextTheme(
      displayLarge: h1Style,
      displayMedium: h2Style,
      displaySmall: h3Style,
      headlineLarge: h4Style,
      headlineMedium: paragraphStyle,
      headlineSmall: paragraphMediumStyle,
      titleLarge: paragraphSemiBoldStyle,
      titleMedium: paragraphSmallStyle,
      titleSmall: paragraphSmallBoldStyle,
      bodyLarge: bodySd1Style,
      bodyMedium: bodySd2Style,
      bodySmall: captionMediumStyle,
      labelSmall: h7Style,
      labelLarge: h7Style,
      labelMedium: h7Style,
    );
  }

  return ThemeData(
    brightness: Brightness.dark,
    textTheme: buildHighContrastDarkTextTheme(),
    extensions: [extensionColors],
  );
}
