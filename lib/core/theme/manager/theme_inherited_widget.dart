import 'package:flutter/material.dart';
import 'theme_manager.dart';

class ThemeInheritedWidget extends InheritedWidget {
  final ThemeMode themeMode;
  final ContrastMode contrastMode;
  final VoidCallback onThemeChanged;

  const ThemeInheritedWidget({
    super.key,
    required this.themeMode,
    required this.contrastMode,
    required this.onThemeChanged,
    required super.child,
  });

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return themeMode != oldWidget.themeMode ||
        contrastMode != oldWidget.contrastMode;
  }
}
