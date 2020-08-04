import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class IntPreference extends Preference<int> {
  IntPreference({
    SharedPreferences prefs,
    @required String key,
    @required int defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  int doGetValue(String key) => prefs.getInt(key);

  @override
  @protected
  Future<bool> doSetValue(int value) => prefs.setInt(key, value);
}
