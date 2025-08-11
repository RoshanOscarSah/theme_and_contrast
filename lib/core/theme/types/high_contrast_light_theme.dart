import 'package:flutter/material.dart';
import 'package:theme_and_contrast/core/theme/design_system/app_color_extension.dart';
import '../design_system/app_colors.dart';
import '../design_system/app_text_styles.dart';

ThemeData buildHighContrastLightTheme() {
  final extensionColors = ExtensionColors(
    // Override yellow colors with green values
    yellow500: AppColors.BLUE_700,
    brown500: AppColors.BLUE_700,
    emerald500: AppColors.BLUE_700,
    backgroundPrimary: AppColors.BACKGROUND_PRIMARY,
    red500: AppColors.BLUE_700,
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
    brightness: Brightness.light,
    textTheme: buildHighContrastDarkTextTheme(),
    extensions: [extensionColors],
  );
}
