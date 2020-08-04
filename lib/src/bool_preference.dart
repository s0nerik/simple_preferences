import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class BoolPreference extends Preference<bool> {
  BoolPreference({
    SharedPreferences prefs,
    @required String key,
    @required bool defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  bool doGetValue(String key) => prefs.getBool(key);

  @override
  @protected
  Future<bool> doSetValue(bool value) => prefs.setBool(key, value);
}
