import 'package:flutter/material.dart';
import 'app_lifecycle_handler.dart';

class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  late AppLifecycleHandler _lifecycleHandler;

  @override
  void initState() {
    super.initState();

    _lifecycleHandler = AppLifecycleHandler(
      onAppResumed: () {
        // Handle app resumed - refresh theme/contrast settings
        debugPrint('App resumed - checking for theme/contrast changes');
      },
      onAppPaused: () {
        // Handle app paused
        debugPrint('App paused');
      },
    );
  }

  @override
  void dispose() {
    _lifecycleHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
