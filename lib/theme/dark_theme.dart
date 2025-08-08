import 'package:flutter/material.dart';

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(elevation: 0),
    cardTheme: const CardTheme(elevation: 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(elevation: 1),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 3,
    ),
  );
}
