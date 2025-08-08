import 'dart:io';

import 'package:flutter/material.dart';

import '../models/contrast_mode.dart';
import '../widgets/appearance_modal.dart';
import '../widgets/color_swatch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onThemeToggle,
    required this.onContrastToggle,
    required this.themeMode,
    required this.contrastMode,
    required this.platformHighContrast,
  });

  final String title;
  final VoidCallback onThemeToggle;
  final VoidCallback onContrastToggle;
  final ThemeMode themeMode;
  final ContrastMode contrastMode;
  final bool platformHighContrast;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _getThemeModeText() {
    switch (widget.themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  String _getContrastModeText() {
    switch (widget.contrastMode) {
      case ContrastMode.normal:
        return 'Normal';
      case ContrastMode.high:
        return 'High';
      case ContrastMode.system:
        return 'System';
    }
  }

  void _showAppearanceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AppearanceModal(
            themeMode: widget.themeMode,
            contrastMode: widget.contrastMode,
            onThemeToggle: widget.onThemeToggle,
            onContrastToggle: widget.onContrastToggle,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHighContrast = MediaQuery.of(context).highContrast;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => _showAppearanceModal(context),
            icon: const Icon(Icons.palette),
            tooltip: 'Appearance Settings',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      widget.themeMode == ThemeMode.light
                          ? Icons.light_mode
                          : widget.themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.brightness_auto,
                      size: 48,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Theme: ${_getThemeModeText()}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Contrast Mode: ${_getContrastModeText()}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Brightness: ${isDark ? "Dark" : "Light"}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    if (Platform.isAndroid)
                      Text(
                        'High Contrast: ${widget.platformHighContrast ? "Enabled" : "Disabled"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (Platform.isIOS)
                      Text(
                        'High Contrast: ${isHighContrast ? "Enabled" : "Disabled"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: widget.onThemeToggle,
                  icon: Icon(
                    widget.themeMode == ThemeMode.light
                        ? Icons.light_mode
                        : widget.themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.brightness_auto,
                  ),
                  label: const Text('Switch Theme'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: widget.onContrastToggle,
                  icon: Icon(
                    widget.contrastMode == ContrastMode.high
                        ? Icons.contrast
                        : widget.contrastMode == ContrastMode.system
                        ? Icons.brightness_auto
                        : Icons.contrast_outlined,
                  ),
                  label: const Text('Toggle Contrast'),
                ),
              ],
            ),

            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Color Palette',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        DemoColorSwatch('Primary', colorScheme.primary),
                        DemoColorSwatch('Secondary', colorScheme.secondary),
                        DemoColorSwatch('Surface', colorScheme.surface),
                        DemoColorSwatch('Background', colorScheme.surface),
                        DemoColorSwatch('Error', colorScheme.error),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
