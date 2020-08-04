import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/preference.dart';

typedef ValueMapper<T> = String Function(T value);

String _defaultMapper(dynamic value) {
  if (value == null) {
    return null;
  }

  final str = value.toString();
  final dotIndex = str.indexOf('.');
  if (dotIndex > 0) {
    return str.substring(dotIndex);
  }
  throw ArgumentError.value(value, 'value', 'must be an enum');
}

class EnumPreference<T extends Object> extends Preference<T> {
  EnumPreference({
    SharedPreferences prefs,
    @required String key,
    @required T defaultValue,
    @required List<T> values,
    this.mapper = _defaultMapper,
  })  : assert(values != null),
        _values = values,
        super(prefs, key, defaultValue);

  final List<T> _values;
  final ValueMapper<T> mapper;

  @override
  @protected
  T doGetValue(String key) => _values.firstWhere(
        (value) => mapper(value) == prefs.getString(key),
        orElse: () => defaultValue,
      );

  @override
  @protected
  Future<bool> doSetValue(T value) => prefs.setString(key, mapper(value));
}
