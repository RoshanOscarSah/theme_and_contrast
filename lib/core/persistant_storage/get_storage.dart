import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class GetSetStorage {
  static GetStorage? _box;
  static bool _initialized = false;

  // Initialize the storage
  static Future<void> init() async {
    if (_initialized) return;

    await GetStorage.init();
    _box = GetStorage();
    _initialized = true;
  }

  static GetStorage get _storage {
    if (!_initialized || _box == null) {
      throw Exception(
        'GetStorage not initialized. Call GetSetStorage.init() first.',
      );
    }
    return _box!;
  }

  // clear all storage
  bool clear() {
    _storage.erase();
    return true;
  }

  void erase(String key) {
    _storage.remove(key);
  }

  bool clearLoggedData() {
    const List<String> authTags = ["ACCESS_TOKEN_TAG"];
    for (final tag in authTags) {
      _storage.remove(tag);
    }
    return true;
  }

  // Generic method to write data (handles both String and bool)
  bool _setData(String key, dynamic value) {
    _storage.write(key, value);
    return true;
  }

  // Generic method to read data (returns String or bool based on the type)
  dynamic _getData(String key) {
    return _storage.read(key);
  }

  String? getString(String key) {
    return _storage.read(key);
  }

  void setString(String key, String value) {
    _storage.write(key, value);
  }

  bool? getBool(String key) => _getData(key);

  bool setBool(String key, bool value) => _setData(key, value);

  int? getInt(String key) => _getData(key);

  bool setInt(String key, int value) => _setData(key, value);

  double? getDouble(String key) => _getData(key);

  bool setDouble(String key, double value) => _setData(key, value);

  T? getOrNull<T>(String key) {
    final value = _getData(key);
    final decodedValue = _decodeValue<T>(value);
    return (decodedValue is T) ? decodedValue : null;
  }

  bool isType<T, Y>() => T == Y;

  void changeListener(String key, ValueSetter callback) {
    _storage.listenKey(key, callback);
  }

  T? _decodeValue<T>(dynamic value) {
    if (value == null) return null;

    if (T == String || T == double || T == int || T == bool) {
      return value as T?;
    }

    if (isType<T, DateTime?>() || isType<T, DateTime>()) {
      return DateTime.parse(value.toString()) as T?;
    }

    return value as T?;
  }

  dynamic _encodeValue<T>(T? value) {
    if (value == null) return null;

    if (value is String || value is double || value is int || value is bool) {
      return value;
    }

    if (value is DateTime) {
      return value.toIso8601String();
    }

    return value;
  }

  void setOrStorage<T>(String key, T? value) {
    final setterValue = _encodeValue<T>(value);
    if (setterValue == null) {
      _storage.remove(key);
    } else {
      _setData(key, setterValue);
    }
  }
}
