import 'package:flutter/material.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text_styles.dart';

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.light(
    primary: AppColors.BRAND_BROWN,
    onPrimary: AppColors.WHITE,
    secondary: AppColors.BRAND_YELLOW,
    onSecondary: AppColors.BLACK,
    surface: AppColors.BACKGROUND_APP,
    onSurface: AppColors.GRAY_TAUPE_700,
    error: AppColors.RED_600,
    onError: AppColors.WHITE,
    outline: AppColors.GRAY_400,
    outlineVariant: AppColors.GRAY_300,
    shadow: AppColors.BLACK.withValues(alpha: 0.1),
    scrim: AppColors.BLACK.withValues(alpha: 0.32),
    surfaceContainerHighest: AppColors.GRAY_100,
    onSurfaceVariant: AppColors.GRAY_700,
  );

  TextTheme buildLightTextTheme() {
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
    scaffoldBackgroundColor: AppColors.BACKGROUND_APP,
    textTheme: buildLightTextTheme(),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
    cardTheme: const CardTheme(elevation: 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 3,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(colorScheme.onPrimary),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
    ),
  );
}
