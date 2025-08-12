import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'core/theme/manager/theme_manager.dart';
import 'core/theme/manager/theme_inherited_widget.dart';
import 'core/lifecycle/app_wrapper.dart';
import 'core/persistant_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage first
  await GetSetStorage.init();

  // Initialize theme manager and load saved preferences
  ThemeManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      onAppResumed: () {
        // Force rebuild when app resumes to reflect any system changes
        setState(() {});
      },
      child: ThemeInheritedWidget(
        themeMode: ThemeManager.themeMode,
        contrastMode: ThemeManager.contrastMode,
        onThemeChanged: _onThemeChanged,
        child: MaterialApp(
          title: 'Theme & Contrast Demo',
          themeMode: ThemeManager.themeMode,
          theme: ThemeManager.getLightTheme(),
          darkTheme: ThemeManager.getDarkTheme(),
          highContrastTheme: ThemeManager.getHighContrastLightTheme(),
          highContrastDarkTheme: ThemeManager.getHighContrastDarkTheme(),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
