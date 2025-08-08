import 'dart:io';
import 'package:flutter/services.dart';

class ContrastService {
  static const MethodChannel _channel = MethodChannel(
    'com.example.accessibility/contrast',
  );

  static Future<bool> isHighContrastEnabled() async {
    if (!Platform.isAndroid) return false;
    try {
      final bool result = await _channel.invokeMethod('isHighContrastEnabled');
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<String>> listAccessibilitySettings() async {
    if (!Platform.isAndroid) return const [];
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'listAccessibilitySettings',
      );
      return result.cast<String>();
    } on PlatformException {
      return [];
    }
  }
}
