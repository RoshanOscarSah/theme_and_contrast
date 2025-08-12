import 'package:flutter/material.dart';
import '../types/theme_dark.dart';
import '../types/high_contrast_dark_theme.dart';
import '../types/high_contrast_light_theme.dart';
import '../types/theme_light.dart';
import '../../persistant_storage/theme_preferences.dart';
import '../manager/contrast_manager.dart';
import '../../utils/performance_monitor.dart';

enum ContrastMode { normal, high, system }

class ThemeManager {
  static ThemeMode _themeMode = ThemeMode.system;
  static ContrastMode _contrastMode = ContrastMode.system;
  static final List<Function()> _listeners = [];
  static bool _initialized = false;
  static bool _isLoading = false; // Flag to prevent saving during loading
  static bool _systemHighContrastEnabled =
      false; // Track system high contrast state

  // Cache theme data for better performance
  static ThemeData? _cachedLightTheme;
  static ThemeData? _cachedDarkTheme;
  static ThemeData? _cachedHighContrastLightTheme;
  static ThemeData? _cachedHighContrastDarkTheme;
  static bool _cacheValid = false;

  // Initialize the theme manager and load saved preferences
  static void initialize() {
    if (_initialized) return;

    PerformanceMonitor.startTimer('theme_initialization');
    _isLoading = true;
    // Load saved preferences
    ThemePreferences.loadPreferences();
    _isLoading = false;
    _initialized = true;

    // Check initial system high contrast status
    _checkSystemHighContrast();
    PerformanceMonitor.endTimer('theme_initialization');
  }

  static void addListener(Function() listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  static void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  static void _notifyListeners() {
    // Invalidate cache when notifying listeners
    _cacheValid = false;

    for (final listener in _listeners) {
      try {
        listener();
      } catch (e) {
        // Silently handle listener errors
      }
    }
  }

  // Check if system high contrast is enabled
  static Future<bool> isSystemHighContrastEnabled() async {
    try {
      return await ContrastService.isHighContrastEnabled();
    } catch (e) {
      return false;
    }
  }

  // Check and update system high contrast status
  static Future<void> _checkSystemHighContrast() async {
    final wasEnabled = _systemHighContrastEnabled;
    _systemHighContrastEnabled = await isSystemHighContrastEnabled();

    // If system high contrast status changed, notify listeners
    if (wasEnabled != _systemHighContrastEnabled) {
      _notifyListeners();
    }
  }

  // Refresh theme based on current system settings
  static Future<void> refreshSystemSettings() async {
    PerformanceMonitor.startTimer('refresh_system_settings');
    // Check if system high contrast is enabled
    final isSystemHighContrast = await isSystemHighContrastEnabled();

    // Update the system high contrast status
    _systemHighContrastEnabled = isSystemHighContrast;

    // If contrast mode is set to system, we need to notify listeners
    // so the app can rebuild with the correct theme
    if (_contrastMode == ContrastMode.system) {
      _notifyListeners();
    }
    PerformanceMonitor.endTimer('refresh_system_settings');
  }

  // Helper method to determine if high contrast should be applied
  static bool _shouldUseHighContrast() {
    if (_contrastMode == ContrastMode.high) {
      return true;
    }
    if (_contrastMode == ContrastMode.system) {
      return _systemHighContrastEnabled;
    }
    return false;
  }

  // Build and cache themes for better performance
  static void _buildCachedThemes() {
    if (_cacheValid) return;

    PerformanceMonitor.startTimer('build_cached_themes');
    _cachedLightTheme = buildLightTheme();
    _cachedDarkTheme = buildDarkTheme();
    _cachedHighContrastLightTheme = buildHighContrastLightTheme();
    _cachedHighContrastDarkTheme = buildHighContrastDarkTheme();
    _cacheValid = true;
    PerformanceMonitor.endTimer('build_cached_themes');
  }

  static ThemeData getLightTheme() {
    _buildCachedThemes();
    // Check if we should use high contrast based on current settings
    if (_shouldUseHighContrast()) {
      return _cachedHighContrastLightTheme!;
    }
    return _cachedLightTheme!;
  }

  static ThemeData getDarkTheme() {
    _buildCachedThemes();
    // Check if we should use high contrast based on current settings
    if (_shouldUseHighContrast()) {
      return _cachedHighContrastDarkTheme!;
    }
    return _cachedDarkTheme!;
  }

  static ThemeData? getHighContrastLightTheme() {
    // Only provide high contrast theme if system mode is set
    if (_contrastMode == ContrastMode.system) {
      _buildCachedThemes();
      return _cachedHighContrastLightTheme;
    }
    return null;
  }

  static ThemeData? getHighContrastDarkTheme() {
    // Only provide high contrast theme if system mode is set
    if (_contrastMode == ContrastMode.system) {
      _buildCachedThemes();
      return _cachedHighContrastDarkTheme;
    }
    return null;
  }

  static void setContrastMode(ContrastMode contrastMode) {
    _contrastMode = contrastMode;
    // Save to persistent storage only if not loading
    if (!_isLoading) {
      ThemePreferences.setContrastMode(contrastMode);
    }
    _notifyListeners();
  }

  static void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    // Save to persistent storage only if not loading
    if (!_isLoading) {
      ThemePreferences.setThemeMode(themeMode);
    }
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

  // Getter for current system high contrast status
  static bool get systemHighContrastEnabled => _systemHighContrastEnabled;
}
