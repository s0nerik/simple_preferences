import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'json_preference.dart';

class JsonListPreference<T> extends JsonPreference<List<T>> {
  JsonListPreference({
    SharedPreferences prefs,
    @required String key,
    List<T> defaultValue = const [],
    @required PreferenceJsonEncoder<T> itemEncoder,
    @required PreferenceJsonDecoder<T> itemDecoder,
  })  : assert(defaultValue != null),
        super(
          prefs: prefs,
          key: key,
          defaultValue: defaultValue,
          encoder: (items) => items.map(itemEncoder).toList(),
          decoder: (items) => (items as List).map(itemDecoder).toList(),
        );
}
