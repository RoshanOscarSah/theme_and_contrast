import 'dart:io';

import 'package:flutter/material.dart';
import 'package:theme_and_contrast/core/theme/manager/theme_manager.dart';

import 'widgets/appearance_modal.dart';
import 'widgets/color_swatch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Listen to theme changes
    ThemeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    // Remove listener when widget is disposed
    ThemeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {
      // Rebuild the widget when theme changes
    });
  }

  String _getThemeModeText() {
    switch (ThemeManager.themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  String _getContrastModeText() {
    switch (ThemeManager.contrastMode) {
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
      builder: (context) => const AppearanceModal(),
    );
  }

  void _toggleTheme() {
    ThemeManager.toggleTheme();
  }

  void _toggleContrast() {
    ThemeManager.toggleContrast();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dynamic Theme Demo',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This ListTile adapts to your current theme:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Dynamic Switch",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Switch.adaptive(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Current Theme Info:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Primary: ${Theme.of(context).colorScheme.primary}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '• Surface: ${Theme.of(context).colorScheme.surface}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '• On Surface: ${Theme.of(context).colorScheme.onSurface}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
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
                          'High Contrast: ${isHighContrast ? "Enabled" : "Disabled"}',
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
                    onPressed: _toggleTheme,
                    icon: Icon(
                      ThemeManager.themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    label: const Text('Switch Theme'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _toggleContrast,
                    icon: Icon(
                      ThemeManager.contrastMode == ContrastMode.high
                          ? Icons.contrast
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
      ),
    );
  }
}
