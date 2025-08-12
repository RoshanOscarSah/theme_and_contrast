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
    debugPrint('🔄 AppWrapper: Initializing lifecycle handler');

    _lifecycleHandler = AppLifecycleHandler(
      onAppResumed: () {
        // Handle app resumed - refresh theme/contrast settings
        debugPrint('🔄 AppWrapper: App resumed callback triggered');
        widget.onAppResumed?.call();
      },
      onAppPaused: () {
        // Handle app paused
        debugPrint('🔄 AppWrapper: App paused callback triggered');
        widget.onAppPaused?.call();
      },
    );
  }

  @override
  void dispose() {
    debugPrint('🔄 AppWrapper: Disposing lifecycle handler');
    _lifecycleHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
