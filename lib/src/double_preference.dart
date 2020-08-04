import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class DoublePreference extends Preference<double> {
  DoublePreference({
    SharedPreferences prefs,
    @required String key,
    @required double defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  double doGetValue(String key) => prefs.getDouble(key);

  @override
  @protected
  Future<bool> doSetValue(double value) => prefs.setDouble(key, value);
}
