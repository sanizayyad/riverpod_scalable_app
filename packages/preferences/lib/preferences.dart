library preferences;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preferences/preferences.dart';

export './src/preference_storage.dart';

final preferencesProvider = Provider<Preferences>((ref) {
  throw UnimplementedError();
});