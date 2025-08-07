import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ContrastMode { normal, high, system }

class ContrastService {
  static const MethodChannel _channel = MethodChannel(
    'com.example.accessibility/contrast',
  );

  static Future<bool> isHighContrastEnabled() async {
    try {
      final bool result = await _channel.invokeMethod('isHighContrastEnabled');
      print('Platform channel - High contrast enabled 1: $result');
      print('Platform channel - High contrast enabled 2: $result');
      print('Platform channel - High contrast enabled 3: $result');
      return result;
    } on PlatformException catch (e) {
      print('Failed to get contrast setting: ${e.message}');
      return false;
    }
  }

  static Future<List<String>> listAccessibilitySettings() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'listAccessibilitySettings',
      );
      return result.cast<String>();
    } on PlatformException catch (e) {
      print('Failed to list accessibility settings: ${e.message}');
      return [];
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isHighContrast = await ContrastService.isHighContrastEnabled();
  print('Platform channel - High contrast enabled: $isHighContrast');

  // List all accessibility settings to debug
  final settings = await ContrastService.listAccessibilitySettings();
  print('Available accessibility settings:');
  for (final setting in settings) {
    print('  $setting');
  }

  runApp(MyApp(initialHighContrast: isHighContrast));
}

class MyApp extends StatefulWidget {
  final bool initialHighContrast;

  const MyApp({super.key, required this.initialHighContrast});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;
  ContrastMode _contrastMode = ContrastMode.system;
  bool _platformHighContrast = false;

  @override
  void initState() {
    super.initState();
    _platformHighContrast = widget.initialHighContrast;
    print(
      'Initial platform high contrast:  [32m [1m [4m [7m$_platformHighContrast [0m',
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshPlatformHighContrast();
    }
  }

  Future<void> refreshPlatformHighContrast() async {
    final newValue = await ContrastService.isHighContrastEnabled();
    if (mounted && newValue != _platformHighContrast) {
      setState(() {
        _platformHighContrast = newValue;
      });
      print('Refreshed platform high contrast: $_platformHighContrast');
    }
  }

  void _toggleTheme() {
    setState(() {
      switch (_themeMode) {
        case ThemeMode.light:
          _themeMode = ThemeMode.dark;
          break;
        case ThemeMode.dark:
          _themeMode = ThemeMode.system;
          break;
        case ThemeMode.system:
          _themeMode = ThemeMode.light;
          break;
      }
    });
    print('Theme changed to: $_themeMode');
  }

  void _toggleContrast() {
    setState(() {
      switch (_contrastMode) {
        case ContrastMode.normal:
          _contrastMode = ContrastMode.high;
          break;
        case ContrastMode.high:
          _contrastMode = ContrastMode.system;
          break;
        case ContrastMode.system:
          _contrastMode = ContrastMode.normal;
          break;
      }
    });
    print('Contrast changed to: $_contrastMode');
  }

  @override
  Widget build(BuildContext context) {
    print('=== MATERIAL APP BUILD ===');
    print('Theme Mode: $_themeMode');
    print('Contrast Mode: $_contrastMode');
    print('Platform High Contrast: $_platformHighContrast');
    print('Using highContrastTheme: ${_contrastMode == ContrastMode.system}');
    print('==========================');

    return MaterialApp(
      title: 'Theme & Contrast Demo',
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      // Only use native high contrast themes when in System mode
      highContrastTheme:
          _contrastMode == ContrastMode.system
              ? _buildHighContrastLightTheme()
              : null,
      highContrastDarkTheme:
          _contrastMode == ContrastMode.system
              ? _buildHighContrastDarkTheme()
              : null,
      home: MyHomePage(
        title: 'Theme & Contrast Demo',
        onThemeToggle: _toggleTheme,
        onContrastToggle: _toggleContrast,
        themeMode: _themeMode,
        contrastMode: _contrastMode,
        platformHighContrast: _platformHighContrast,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    print('Building Light Theme - Contrast Mode: $_contrastMode');
    // For System mode, let the native highContrastTheme handle it
    if (_contrastMode == ContrastMode.system) {
      print('Using standard light theme for System mode');
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
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

    // For manual modes, handle contrast directly
    if (_contrastMode == ContrastMode.high) {
      print('Using high contrast light theme');
      return _buildHighContrastLightTheme();
    }

    print('Using normal light theme');

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
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

  ThemeData _buildDarkTheme() {
    print('Building Dark Theme - Contrast Mode: $_contrastMode');
    // For System mode, let the native highContrastDarkTheme handle it
    if (_contrastMode == ContrastMode.system) {
      print('Using standard dark theme for System mode');
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

    // For manual modes, handle contrast directly
    if (_contrastMode == ContrastMode.high) {
      print('Using high contrast dark theme');
      return _buildHighContrastDarkTheme();
    }

    print('Using normal dark theme');

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

  ThemeData _buildHighContrastLightTheme() {
    print(
      'Building High Contrast Light Theme - This should be applied when system high contrast is ON',
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        brightness: Brightness.light,
      ).copyWith(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        error: Colors.red.shade900,
        onError: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      cardTheme: const CardTheme(
        elevation: 4,
        color: Colors.white,
        shadowColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
    );
  }

  ThemeData _buildHighContrastDarkTheme() {
    print(
      'Building High Contrast Dark Theme - This should be applied when system high contrast is ON',
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        brightness: Brightness.dark,
      ).copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.white,
        onSecondary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
        error: Colors.red.shade100,
        onError: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 4,
      ),
      cardTheme: const CardTheme(
        elevation: 4,
        color: Colors.black,
        shadowColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 4,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 6,
      ),
    );
  }
}

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    final mediaQuery = MediaQuery.of(context);

    // Debug prints for contrast detection
    print('=== CONTRAST DEBUG INFO ===');
    print('Theme Mode: ${widget.themeMode}');
    print('Contrast Mode: ${widget.contrastMode}');
    print('MediaQuery.highContrast: $isHighContrast');
    print(
      'MediaQuery.accessibleNavigation: ${mediaQuery.accessibleNavigation}',
    );
    print('Platform High Contrast: ${widget.platformHighContrast}');
    print('Current Brightness: ${isDark ? "Dark" : "Light"}');
    print('Platform: ${Theme.of(context).platform}');
    print(
      'Platform Channel Result: ${widget.contrastMode == ContrastMode.system ? "Check platform channel" : "N/A"}',
    );
    print('==========================');

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
            // Theme Info Card
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

            // Theme Controls
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
                  label: Text('Switch Theme'),
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
                  label: Text('Toggle Contrast'),
                ),
              ],
            ),

            // Color Palette Demo
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
                        _ColorSwatch('Primary', colorScheme.primary),
                        _ColorSwatch('Secondary', colorScheme.secondary),
                        _ColorSwatch('Surface', colorScheme.surface),
                        _ColorSwatch('Background', colorScheme.surface),
                        _ColorSwatch('Error', colorScheme.error),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorSwatch(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class AppearanceModal extends StatefulWidget {
  final ThemeMode themeMode;
  final ContrastMode contrastMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onContrastToggle;

  const AppearanceModal({
    super.key,
    required this.themeMode,
    required this.contrastMode,
    required this.onThemeToggle,
    required this.onContrastToggle,
  });

  @override
  State<AppearanceModal> createState() => _AppearanceModalState();
}

class _AppearanceModalState extends State<AppearanceModal> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Section
                  _buildSectionTitle('Theme'),
                  const SizedBox(height: 16),
                  _buildThemeOptions(),

                  const SizedBox(height: 32),

                  // Contrast Section
                  _buildSectionTitle('Contrast'),
                  const SizedBox(height: 16),
                  _buildContrastOptions(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildThemeOptions() {
    return Row(
      children: [
        Expanded(child: _buildThemeCard(ThemeMode.light, 'Light')),
        const SizedBox(width: 12),
        Expanded(child: _buildThemeCard(ThemeMode.dark, 'Dark')),
        const SizedBox(width: 12),
        Expanded(child: _buildThemeCard(ThemeMode.system, 'System')),
      ],
    );
  }

  Widget _buildThemeCard(ThemeMode themeMode, String title) {
    final isSelected = widget.themeMode == themeMode;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        widget.onThemeToggle();
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            _buildThemePreview(themeMode),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      // System mode: split design showing both light and dark possibilities
      return Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            // Left half - Light theme
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // App bar preview (light)
                      Container(
                        width: 20,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Content preview (light)
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Right half - Dark theme
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // App bar preview (dark)
                      Container(
                        width: 20,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Content preview (dark)
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Light or Dark mode: single theme preview
      final isDark = themeMode == ThemeMode.dark;

      return Container(
        height: 60,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // App bar preview
              Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              // Content preview
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildContrastOptions() {
    return Row(
      children: [
        Expanded(child: _buildContrastCard(ContrastMode.normal, 'Normal')),
        const SizedBox(width: 12),
        Expanded(child: _buildContrastCard(ContrastMode.high, 'High')),
        const SizedBox(width: 12),
        Expanded(child: _buildContrastCard(ContrastMode.system, 'System')),
      ],
    );
  }

  Widget _buildContrastCard(ContrastMode contrastMode, String title) {
    final isSelected = widget.contrastMode == contrastMode;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        widget.onContrastToggle();
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            _buildContrastPreview(contrastMode),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContrastPreview(ContrastMode contrastMode) {
    final isHighContrast =
        contrastMode == ContrastMode.high ||
        (contrastMode == ContrastMode.system &&
            MediaQuery.of(context).highContrast);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isHighContrast ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // High contrast indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isHighContrast ? Colors.white : Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.contrast,
                size: 12,
                color: isHighContrast ? Colors.black : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            // Text preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.white : Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 30,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.white : Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
