import 'package:flutter/foundation.dart';

class PerformanceMonitor {
  static final Map<String, Stopwatch> _timers = {};
  static final Map<String, List<Duration>> _measurements = {};

  /// Start timing an operation
  static void startTimer(String operation) {
    if (kDebugMode) {
      _timers[operation] = Stopwatch()..start();
    }
  }

  /// End timing an operation and log the duration
  static void endTimer(String operation) {
    if (kDebugMode) {
      final timer = _timers.remove(operation);
      if (timer != null) {
        timer.stop();
        final duration = timer.elapsed;

        _measurements.putIfAbsent(operation, () => []).add(duration);

        // Log if operation takes longer than 16ms (60fps threshold)
        if (duration.inMilliseconds > 16) {
          debugPrint(
            '⚠️ Performance: $operation took ${duration.inMilliseconds}ms',
          );
        }
      }
    }
  }

  /// Get average duration for an operation
  static Duration? getAverageDuration(String operation) {
    if (!kDebugMode) return null;

    final measurements = _measurements[operation];
    if (measurements == null || measurements.isEmpty) return null;

    final totalMicroseconds = measurements
        .map((d) => d.inMicroseconds)
        .reduce((a, b) => a + b);

    return Duration(microseconds: totalMicroseconds ~/ measurements.length);
  }

  /// Clear all measurements
  static void clear() {
    if (kDebugMode) {
      _timers.clear();
      _measurements.clear();
    }
  }
}
