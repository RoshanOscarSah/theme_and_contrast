import 'dart:io';

import 'package:flutter/material.dart';
import 'package:theme_and_contrast/core/theme/design_system/app_color_extension.dart';
import 'package:theme_and_contrast/core/theme/manager/theme_manager.dart';
import 'package:theme_and_contrast/core/theme/manager/theme_inherited_widget.dart';

import 'widgets/appearance_modal.dart';
import 'widgets/color_swatch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _getThemeModeText(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);
    if (themeInherited == null) return 'Unknown';

    switch (themeInherited.themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  String _getContrastModeText(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);
    if (themeInherited == null) return 'Unknown';

    switch (themeInherited.contrastMode) {
      case ContrastMode.normal:
        return 'Normal';
      case ContrastMode.high:
        return 'High';
      case ContrastMode.system:
        return 'System';
    }
  }

  String _getCurrentHighContrastStatus() {
    final themeInherited = ThemeInheritedWidget.of(context);
    if (themeInherited == null) return 'Unknown';

    switch (themeInherited.contrastMode) {
      case ContrastMode.high:
        return 'Enabled (App)';
      case ContrastMode.system:
        // Check if system high contrast is enabled
        if (ThemeManager.systemHighContrastEnabled) {
          return 'Enabled (System)';
        } else {
          return 'Disabled (System)';
        }
      case ContrastMode.normal:
        return 'Disabled (App)';
    }
  }

  void _showAppearanceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AppearanceModal(),
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
        title: const Text('Theme & Contrast Demo'),
        actions: [
          IconButton(
            onPressed: () => _showAppearanceModal(context),
            icon: const Icon(Icons.palette),
            tooltip: 'Appearance Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Theme Demo Section
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        ThemeManager.themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        size: 48,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current Theme: ${_getThemeModeText(context)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Contrast Mode: ${_getContrastModeText(context)}',
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
                          'High Contrast: ${_getCurrentHighContrastStatus()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      if (Platform.isIOS)
                        Text(
                          'High Contrast ios: ${isHighContrast ? "Enabled" : "Disabled"}',
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
                    onPressed: () {
                      ThemeManager.toggleTheme();
                    },
                    icon: Builder(
                      builder: (context) {
                        final themeInherited = ThemeInheritedWidget.of(context);
                        return Icon(
                          themeInherited?.themeMode == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        );
                      },
                    ),
                    label: const Text('Switch Theme'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      ThemeManager.toggleContrast();
                    },
                    icon: Builder(
                      builder: (context) {
                        final themeInherited = ThemeInheritedWidget.of(context);
                        return Icon(
                          themeInherited?.contrastMode == ContrastMode.high
                              ? Icons.contrast
                              : Icons.contrast_outlined,
                        );
                      },
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
                          DemoColorSwatch(
                            'Yellow',
                            Theme.of(context).extensionColors.yellow500,
                          ),
                          DemoColorSwatch(
                            'Brown',
                            Theme.of(context).extensionColors.brown500,
                          ),
                          DemoColorSwatch(
                            'Emerald',
                            Theme.of(context).extensionColors.emerald500,
                          ),
                          DemoColorSwatch(
                            'Background',
                            Theme.of(context).extensionColors.backgroundPrimary,
                          ),
                          DemoColorSwatch(
                            'Error',
                            Theme.of(context).extensionColors.red500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
