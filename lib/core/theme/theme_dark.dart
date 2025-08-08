import 'package:flutter/material.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text_styles.dart';

ThemeData buildDarkTheme() {
  final colorScheme = ColorScheme.dark(
    primary: AppColors.BRAND_YELLOW,
    onPrimary: AppColors.BLACK,
    secondary: AppColors.GRAY_TAUPE_400,
    onSecondary: AppColors.WHITE,
    surface: AppColors.GRAY_900,
    onSurface: AppColors.GRAY_100,
    error: AppColors.RED_400,
    onError: AppColors.BLACK,
    outline: AppColors.GRAY_600,
    outlineVariant: AppColors.GRAY_700,
    shadow: AppColors.BLACK.withValues(alpha: 0.3),
    scrim: AppColors.BLACK.withValues(alpha: 0.6),
    surfaceContainerHighest: AppColors.GRAY_800,
    onSurfaceVariant: AppColors.GRAY_300,
  );

  TextTheme buildDarkTextTheme() {
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
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.GRAY_900,
    textTheme: buildDarkTextTheme(),
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
