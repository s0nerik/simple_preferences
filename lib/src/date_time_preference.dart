import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

class DateTimePreference extends Preference<DateTime> {
  DateTimePreference({
    SharedPreferences prefs,
    @required String key,
    @required DateTime defaultValue,
  }) : super(prefs, key, defaultValue);

  @override
  @protected
  DateTime doGetValue(String key) {
    final dateStr = prefs.getString(key);
    if (dateStr == null) {
      return null;
    }
    return DateTime.tryParse(dateStr);
  }

  @override
  @protected
  Future<bool> doSetValue(DateTime value) =>
      prefs.setString(key, value?.toIso8601String());
}
