import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/manager/contrast_manager.dart';
import '../theme/manager/theme_manager.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppPaused;
  Timer? _debounceTimer;
  bool _isProcessing = false;
  bool _isDisposed = false;

  AppLifecycleHandler({this.onAppResumed, this.onAppPaused}) {
    WidgetsBinding.instance.addObserver(this);
    _checkInitialContrastStatus();
  }

  void dispose() {
    debugPrint('🔄 AppLifecycleHandler: Disposing...');
    _isDisposed = true;

    // Cancel timer but don't set to null immediately
    _debounceTimer?.cancel();

    // Remove observer
    WidgetsBinding.instance.removeObserver(this);

    // Set timer to null after a short delay to allow pending operations to complete
    Timer(const Duration(milliseconds: 100), () {
      _debounceTimer = null;
      debugPrint('🔄 AppLifecycleHandler: Disposed completely');
    });
  }

  void _checkInitialContrastStatus() async {
    try {
      final isHighContrast = await ContrastService.isHighContrastEnabled();
      debugPrint('Initial high contrast status: $isHighContrast');
    } catch (e) {
      debugPrint('Error checking initial contrast status: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('🔄 Lifecycle state changed: $state');

    // Check if the handler is disposed
    if (_isDisposed) {
      debugPrint('🔄 Handler disposed, ignoring lifecycle event');
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('🔄 App resumed - triggering handler');
        _handleAppResumed();
        break;
      case AppLifecycleState.paused:
        debugPrint('🔄 App paused - triggering handler');
        _handleAppPaused();
        break;
      case AppLifecycleState.inactive:
        debugPrint('App became inactive');
        break;
      case AppLifecycleState.detached:
        debugPrint('App detached');
        break;
      case AppLifecycleState.hidden:
        debugPrint('App hidden');
        break;
    }
  }

  void _handleAppResumed() {
    debugPrint('🔄 App resumed - checking for system changes');
    // Debounce rapid resume events
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      debugPrint('🔄 Debounced resume event triggered');
      // Check if the handler is still valid before processing
      if (!_isProcessing && !_isDisposed) {
        _isProcessing = true;
        debugPrint('🔄 Starting contrast check...');
        _checkContrastChanges()
            .then((_) {
              // Always call onAppResumed if not disposed
              if (!_isDisposed && onAppResumed != null) {
                debugPrint('🔄 Calling onAppResumed callback');
                onAppResumed?.call();
              }
              _isProcessing = false;
            })
            .catchError((error) {
              debugPrint('Error in contrast check: $error');
              _isProcessing = false;
            });
      } else {
        debugPrint('🔄 Already processing or disposed, skipping...');
      }
    });
  }

  void _handleAppPaused() {
    debugPrint('App paused');
    onAppPaused?.call();
  }

  Future<void> _checkContrastChanges() async {
    try {
      debugPrint('🔄 Checking contrast changes...');
      final isHighContrast = await ContrastService.isHighContrastEnabled();
      debugPrint('High contrast status on resume: $isHighContrast');

      // Refresh theme manager to check for system accessibility changes
      await ThemeManager.refreshSystemSettings();
      debugPrint('🔄 Theme refresh completed');
    } catch (e) {
      debugPrint('Error checking contrast changes: $e');
    }
  }
}
