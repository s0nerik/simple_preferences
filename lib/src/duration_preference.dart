import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class DurationPreference extends Preference<Duration> {
  DurationPreference({
    SharedPreferences prefs,
    @required String key,
    @required Duration defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  Duration doGetValue(String key) {
    final durationStr = prefs.getString(key);
    if (durationStr == null) {
      return null;
    }
    return Duration(microseconds: int.parse(durationStr));
  }

  @override
  @protected
  Future<bool> doSetValue(Duration value) {
    if (value == null) {
      return prefs.setString(key, null);
    }
    return prefs.setString(key, value.inMicroseconds.toString());
  }
}
