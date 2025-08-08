import 'package:flutter/material.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text_styles.dart';

ThemeData buildHighContrastDarkTheme() {
  final colorScheme = ColorScheme.dark(
    primary: AppColors.WHITE,
    onPrimary: AppColors.BLACK,
    secondary: AppColors.WHITE,
    onSecondary: AppColors.BLACK,
    surface: AppColors.BLACK,
    onSurface: AppColors.WHITE,
    error: AppColors.RED_100,
    onError: AppColors.BLACK,
    outline: AppColors.WHITE,
    outlineVariant: AppColors.GRAY_600,
    shadow: AppColors.WHITE.withValues(alpha: 0.5),
    scrim: AppColors.WHITE.withValues(alpha: 0.8),
    surfaceContainerHighest: AppColors.GRAY_900,
    onSurfaceVariant: AppColors.WHITE,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: AppColors.WHITE,
    scaffoldBackgroundColor: AppColors.BLACK,
    textTheme: TextTheme(
      headlineSmall: h3Style.copyWith(color: AppColors.WHITE),
      titleLarge: h2Style.copyWith(color: AppColors.WHITE),
      bodyLarge: paragraphMediumStyle.copyWith(color: AppColors.WHITE),
      bodyMedium: paragraphStyle.copyWith(color: AppColors.WHITE),
      bodySmall: captionMediumStyle.copyWith(color: AppColors.WHITE),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.WHITE,
      foregroundColor: AppColors.BLACK,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.BLACK,
      shadowColor: AppColors.WHITE,
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.WHITE,
        foregroundColor: AppColors.BLACK,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.WHITE,
      foregroundColor: AppColors.BLACK,
      elevation: 3,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.BLACK),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.WHITE;
        }
        return AppColors.GRAY_600;
      }),
    ),
  );
}
