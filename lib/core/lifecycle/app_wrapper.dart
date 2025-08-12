import 'package:flutter/material.dart';
import 'app_lifecycle_handler.dart';

class AppWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppPaused;

  const AppWrapper({
    super.key,
    required this.child,
    this.onAppResumed,
    this.onAppPaused,
  });

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
        widget.onAppResumed?.call();
      },
      onAppPaused: () {
        widget.onAppPaused?.call();
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
