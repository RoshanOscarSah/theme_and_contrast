import 'package:flutter/material.dart';
import '../types/theme_dark.dart';
import '../types/high_contrast_dark_theme.dart';
import '../types/high_contrast_light_theme.dart';
import '../types/theme_light.dart';
import '../../persistant_storage/theme_preferences.dart';

enum ContrastMode { normal, high, system }

class ThemeManager {
  static ThemeMode _themeMode = ThemeMode.system;
  static ContrastMode _contrastMode = ContrastMode.system;
  static final List<Function()> _listeners = [];
  static bool _initialized = false;
  static bool _isLoading = false; // Flag to prevent saving during loading

  // Initialize the theme manager and load saved preferences
  static void initialize() {
    if (_initialized) {
      return;
    }

    _isLoading = true;
    // Load saved preferences
    ThemePreferences.loadPreferences();
    _isLoading = false;
    _initialized = true;
  }

  static void addListener(Function() listener) {
    _listeners.add(listener);
  }

  static void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  static void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

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

  static void setContrastMode(ContrastMode contrastMode) {
    _contrastMode = contrastMode;
    // Save to persistent storage only if not loading
    if (!_isLoading) {
      ThemePreferences.setContrastMode(contrastMode);
    } else {}
    _notifyListeners();
  }

  static void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    // Save to persistent storage only if not loading
    if (!_isLoading) {
      ThemePreferences.setThemeMode(themeMode);
    } else {}
    _notifyListeners();
  }

  static void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
    }
  }

  static void toggleContrast() {
    switch (_contrastMode) {
      case ContrastMode.normal:
        setContrastMode(ContrastMode.high);
        break;
      case ContrastMode.high:
        setContrastMode(ContrastMode.system);
        break;
      case ContrastMode.system:
        setContrastMode(ContrastMode.normal);
        break;
    }
  }

  static ThemeMode get themeMode => _themeMode;
  static ContrastMode get contrastMode => _contrastMode;
}
