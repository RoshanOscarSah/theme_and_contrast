import 'package:flutter/material.dart';
import 'get_storage.dart';
import '../theme/manager/theme_manager.dart';

class ThemePreferences {
  static const String _themeModeKey = 'theme_mode';
  static const String _contrastModeKey = 'contrast_mode';

  static final GetSetStorage _storage = GetSetStorage();

  // Getters for current values
  static ThemeMode get themeMode {
    final savedValue = _storage.getString(_themeModeKey);
    return _parseThemeMode(savedValue) ?? ThemeMode.system;
  }

  static ContrastMode get contrastMode {
    final savedValue = _storage.getString(_contrastModeKey);
    return _parseContrastMode(savedValue) ?? ContrastMode.system;
  }

  // Methods to save preferences
  static void setThemeMode(ThemeMode mode) {
    _storage.setString(_themeModeKey, _themeModeToString(mode));
  }

  static void setContrastMode(ContrastMode mode) {
    _storage.setString(_contrastModeKey, _contrastModeToString(mode));
  }

  // Load saved preferences without triggering storage saves
  static void loadPreferences() {
    final savedThemeMode = _storage.getString(_themeModeKey);
    final savedContrastMode = _storage.getString(_contrastModeKey);

    if (savedThemeMode != null) {
      final themeMode = _parseThemeMode(savedThemeMode);
      if (themeMode != null) {
        // Use the regular setter method (it won't save during loading)
        ThemeManager.setThemeMode(themeMode);
      } else {}
    } else {}

    if (savedContrastMode != null) {
      final contrastMode = _parseContrastMode(savedContrastMode);
      if (contrastMode != null) {
        // Use the regular setter method (it won't save during loading)
        ThemeManager.setContrastMode(contrastMode);
      } else {}
    } else {}
  }

  // Helper methods to parse stored strings back to enums
  static ThemeMode? _parseThemeMode(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  static ContrastMode? _parseContrastMode(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'normal':
        return ContrastMode.normal;
      case 'high':
        return ContrastMode.high;
      case 'system':
        return ContrastMode.system;
      default:
        return null;
    }
  }

  // Helper methods to convert enums to strings for storage
  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  static String _contrastModeToString(ContrastMode mode) {
    switch (mode) {
      case ContrastMode.normal:
        return 'normal';
      case ContrastMode.high:
        return 'high';
      case ContrastMode.system:
        return 'system';
    }
  }
}
