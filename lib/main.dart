import 'package:flutter/material.dart';

import 'models/contrast_mode.dart';
import 'screens/home_page.dart';
import 'services/contrast_service.dart';
import 'theme/dark_theme.dart';
import 'theme/high_contrast_dark_theme.dart';
import 'theme/high_contrast_light_theme.dart';
import 'theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isHighContrast = await ContrastService.isHighContrastEnabled();
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
      _refreshPlatformHighContrast();
    }
  }

  Future<void> _refreshPlatformHighContrast() async {
    final newValue = await ContrastService.isHighContrastEnabled();
    if (mounted && newValue != _platformHighContrast) {
      setState(() {
        _platformHighContrast = newValue;
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme & Contrast Demo',
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      highContrastTheme:
          _contrastMode == ContrastMode.system
              ? buildHighContrastLightTheme()
              : null,
      highContrastDarkTheme:
          _contrastMode == ContrastMode.system
              ? buildHighContrastDarkTheme()
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
    if (_contrastMode == ContrastMode.high) {
      return buildHighContrastLightTheme();
    }
    return buildLightTheme();
  }

  ThemeData _buildDarkTheme() {
    if (_contrastMode == ContrastMode.high) {
      return buildHighContrastDarkTheme();
    }
    return buildDarkTheme();
  }
}
