import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class StringPreference extends Preference<String> {
  StringPreference({
    SharedPreferences prefs,
    @required String key,
    @required String defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  String doGetValue(String key) => prefs.getString(key);

  @override
  @protected
  Future<bool> doSetValue(String value) => prefs.setString(key, value);
}
