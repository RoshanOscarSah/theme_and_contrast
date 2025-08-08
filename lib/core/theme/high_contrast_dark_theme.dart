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
    );
  }

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: AppColors.WHITE,
    scaffoldBackgroundColor: AppColors.BLACK,
    textTheme: buildHighContrastDarkTextTheme(),
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
