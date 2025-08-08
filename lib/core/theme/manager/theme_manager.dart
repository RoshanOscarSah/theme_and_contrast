import 'package:flutter/material.dart';
import '../dark_theme.dart';
import '../high_contrast_dark_theme.dart';
import '../high_contrast_light_theme.dart';
import '../light_theme.dart';

enum ContrastMode { normal, high, system }

class ThemeManager {
  static const ThemeMode _themeMode = ThemeMode.system;
  static const ContrastMode _contrastMode = ContrastMode.system;

  static ThemeData getLightTheme() {
    if (_contrastMode == ContrastMode.high) {
      return buildHighContrastLightTheme();
    }
    return buildLightTheme();
  }

  static ThemeData getDarkTheme() {
    if (_contrastMode == ContrastMode.high) {
      return buildHighContrastDarkTheme();
    }
    return buildDarkTheme();
  }

  static ThemeData? getHighContrastLightTheme() {
    if (_contrastMode == ContrastMode.system) {
      return buildHighContrastLightTheme();
    }
    return null;
  }

  static ThemeData? getHighContrastDarkTheme() {
    if (_contrastMode == ContrastMode.system) {
      return buildHighContrastDarkTheme();
    }
    return null;
  }

  static ThemeMode get themeMode => _themeMode;
  static ContrastMode get contrastMode => _contrastMode;
}
