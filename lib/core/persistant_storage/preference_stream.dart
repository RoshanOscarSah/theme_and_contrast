import 'dart:async';

import 'package:theme_and_contrast/core/persistant_storage/get_storage.dart';

class PreferenceStream<T> extends GetSetStorage {
  final _streamController = StreamController<T?>.broadcast();

  Stream<T?> get stream => _streamController.stream;

  late String _key;

  T? _def;

  PreferenceStream._internal(GetSetStorage storage, String key, T? def) {
    _key = key;
    _def = def;
    _streamController.add(getOrNull<T?>(_key) ?? def);
    changeListener(_key, (newValue) {
      _streamController.add(getOrNull<T?>(_key) ?? def);
    });
  }

  void setValue(T value) {
    setOrStorage(_key, value);
  }

  void clearValue() {
    erase(_key);
  }

  T? get value => getOrNull<T?>(_key) ?? _def;

  static PreferenceStream<T> required<T>(
    GetSetStorage storage,
    String key,
    T def,
  ) {
    return PreferenceStream._internal(storage, key, def);
  }

  static PreferenceStream<T?> nullableValue<T>(
    GetSetStorage storage,
    String key,
  ) {
    return PreferenceStream._internal(storage, key, null);
  }
}
