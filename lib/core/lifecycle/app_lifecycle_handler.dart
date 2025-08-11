import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/manager/contrast_manager.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppPaused;
  Timer? _debounceTimer;
  bool _isProcessing = false;

  AppLifecycleHandler({this.onAppResumed, this.onAppPaused}) {
    WidgetsBinding.instance.addObserver(this);
    _checkInitialContrastStatus();
  }

  void dispose() {
    // Cancel timer and set to null to prevent any further usage
    _debounceTimer?.cancel();
    _debounceTimer = null;

    // Reset processing flag
    _isProcessing = false;

    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
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
    // Check if the handler is still valid (not disposed)
    if (_debounceTimer == null) {
      return; // Handler has been disposed, ignore lifecycle events
    }

    switch (state) {
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.paused:
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
    // Debounce rapid resume events
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      // Check if the handler is still valid before processing
      if (!_isProcessing && onAppResumed != null) {
        _isProcessing = true;
        _checkContrastChanges()
            .then((_) {
              // Only call onAppResumed if the timer hasn't been cancelled
              if (_debounceTimer != null) {
                onAppResumed?.call();
              }
              _isProcessing = false;
            })
            .catchError((error) {
              debugPrint('Error in contrast check: $error');
              _isProcessing = false;
            });
      }
    });
  }

  void _handleAppPaused() {
    onAppPaused?.call();
  }

  Future<void> _checkContrastChanges() async {
    try {
      final isHighContrast = await ContrastService.isHighContrastEnabled();
      debugPrint('High contrast status on resume: $isHighContrast');

      // Here you could add logic to refresh theme/contrast settings
      // For example, trigger a rebuild of the app with new contrast settings
    } catch (e) {
      debugPrint('Error checking contrast changes: $e');
    }
  }
}
