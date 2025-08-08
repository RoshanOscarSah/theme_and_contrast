import 'package:flutter/material.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text_styles.dart';

ThemeData buildHighContrastLightTheme() {
  final colorScheme = ColorScheme.light(
    primary: AppColors.BLACK,
    onPrimary: AppColors.WHITE,
    secondary: AppColors.BLACK,
    onSecondary: AppColors.WHITE,
    surface: AppColors.WHITE,
    onSurface: AppColors.BLACK,
    error: AppColors.RED_900,
    onError: AppColors.WHITE,
    outline: AppColors.BLACK,
    outlineVariant: AppColors.GRAY_400,
    shadow: AppColors.BLACK.withValues(alpha: 0.5),
    scrim: AppColors.BLACK.withValues(alpha: 0.8),
    surfaceContainerHighest: AppColors.GRAY_100,
    onSurfaceVariant: AppColors.BLACK,
  );

  TextTheme buildHighContrastLightTextTheme() {
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
    );
  }

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: AppColors.BLACK,
    scaffoldBackgroundColor: AppColors.WHITE,
    textTheme: buildHighContrastLightTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.BLACK,
      foregroundColor: AppColors.WHITE,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.WHITE,
      shadowColor: AppColors.BLACK,
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.BLACK,
        foregroundColor: AppColors.WHITE,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.BLACK,
      foregroundColor: AppColors.WHITE,
      elevation: 3,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.WHITE),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.BLACK;
        }
        return AppColors.GRAY_400;
      }),
    ),
  );
}
