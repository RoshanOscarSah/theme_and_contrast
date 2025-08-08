import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/manager/contrast_manager.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppPaused;
  Timer? _debounceTimer;
  bool _isProcessing = false;

  AppLifecycleHandler({
    this.onAppResumed,
    this.onAppPaused,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _checkInitialContrastStatus();
  }

  void dispose() {
    _debounceTimer?.cancel();
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
      if (!_isProcessing) {
        _isProcessing = true;
        _checkContrastChanges();
        onAppResumed?.call();
        _isProcessing = false;
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
