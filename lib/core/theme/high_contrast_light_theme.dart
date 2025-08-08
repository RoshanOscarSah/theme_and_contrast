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

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: AppColors.BLACK,
    scaffoldBackgroundColor: AppColors.WHITE,
    textTheme: TextTheme(
      headlineSmall: h3Style.copyWith(color: AppColors.BLACK),
      titleLarge: h2Style.copyWith(color: AppColors.BLACK),
      bodyLarge: paragraphMediumStyle.copyWith(color: AppColors.BLACK),
      bodyMedium: paragraphStyle.copyWith(color: AppColors.BLACK),
      bodySmall: captionMediumStyle.copyWith(color: AppColors.BLACK),
    ),
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
