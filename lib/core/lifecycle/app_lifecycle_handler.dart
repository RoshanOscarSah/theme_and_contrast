import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/manager/contrast_manager.dart';
import '../theme/manager/theme_manager.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppPaused;
  Timer? _debounceTimer;
  Timer? _disposeTimer;
  bool _isProcessing = false;
  bool _isDisposed = false;

  AppLifecycleHandler({this.onAppResumed, this.onAppPaused}) {
    WidgetsBinding.instance.addObserver(this);
    _checkInitialContrastStatus();
  }

  void dispose() {
    if (_isDisposed) return;

    _isDisposed = true;

    // Cancel all timers
    _debounceTimer?.cancel();
    _disposeTimer?.cancel();

    // Remove observer
    WidgetsBinding.instance.removeObserver(this);

    // Clean up timers
    _debounceTimer = null;
    _disposeTimer = null;
  }

  void _checkInitialContrastStatus() async {
    try {
      await ContrastService.isHighContrastEnabled();
    } catch (e) {
      // Silently handle error for initial check
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.paused:
        _handleAppPaused();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // No action needed for these states
        break;
    }
  }

  void _handleAppResumed() {
    // Debounce rapid resume events
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (!_isProcessing && !_isDisposed) {
        _isProcessing = true;
        _checkContrastChanges()
            .then((_) {
              if (!_isDisposed && onAppResumed != null) {
                onAppResumed?.call();
              }
              _isProcessing = false;
            })
            .catchError((error) {
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
      await ThemeManager.refreshSystemSettings();
    } catch (e) {
      // Silently handle error
    }
  }
}
