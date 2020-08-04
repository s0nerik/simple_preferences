import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

typedef PreferenceJsonEncoder<T> = dynamic Function(T value);
typedef PreferenceJsonDecoder<T> = T Function(dynamic json);

class JsonPreference<T> extends Preference<T> {
  JsonPreference({
    SharedPreferences prefs,
    @required String key,
    @required T defaultValue,
    @required PreferenceJsonEncoder<T> encoder,
    @required PreferenceJsonDecoder<T> decoder,
  })  : assert(encoder != null),
        assert(decoder != null),
        _encoder = encoder,
        _decoder = decoder,
        super(prefs, key, defaultValue);

  final PreferenceJsonEncoder<T> _encoder;
  final PreferenceJsonDecoder<T> _decoder;

  @override
  @protected
  T doGetValue(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString == null || jsonString.isEmpty) {
      return defaultValue;
    }
    try {
      final jsonMap = jsonDecode(jsonString);
      final value = _decoder(jsonMap);
      return value;
    } catch (_) {
      return defaultValue;
    }
  }

  @override
  @protected
  Future<bool> doSetValue(T value) {
    final jsonMap = _encoder(value);
    final jsonString = jsonEncode(jsonMap);
    return prefs.setString(key, jsonString);
  }
}
