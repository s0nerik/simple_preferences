import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _globalPrefs;

class SimplePreferences {
  static Future<void> init([SharedPreferences sharedPreferences]) async {
    assert(
      _globalPrefs == null,
      'SimplePreferences can only be initialized once',
    );
    if (sharedPreferences != null) {
      _globalPrefs = sharedPreferences;
    } else {
      final prefs = await SharedPreferences.getInstance();
      _globalPrefs = prefs;
    }
  }
}

abstract class Preference<T> with ChangeNotifier implements ValueListenable<T> {
  Preference(SharedPreferences prefs, this.key, this.defaultValue)
      : assert(
          prefs != null || _globalPrefs != null,
          'Either provide `prefs` or initialize `SimplePreferences` with '
          'global SharedPreferences instance using `SimplePreferences.init()` '
          'on application start.',
        ),
        assert(key != null, '`key` must be specified'),
        _prefs = prefs {
    _valueSubject = BehaviorSubject.seeded(doGetValue(key) ?? defaultValue);
  }

  BehaviorSubject<T> _valueSubject;

  final SharedPreferences _prefs;

  @protected
  SharedPreferences get prefs => _prefs ?? _globalPrefs;
  @protected
  final String key;
  @protected
  final T defaultValue;

  ValueStream<T> get stream => _valueSubject;

  @override
  T get value => doGetValue(key) ?? defaultValue;
  set value(T value) => _setValue(value);

  Future<bool> _setValue(T value) async {
    final result = await doSetValue(value);
    if (result == true) {
      _valueSubject.value = value;
      notifyListeners();
    }
    return result;
  }

  @protected
  T doGetValue(String key);

  @protected
  Future<bool> doSetValue(T value);

  Future<bool> clear() {
    return prefs.remove(key);
  }
}
