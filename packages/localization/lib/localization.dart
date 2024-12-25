library;

export './src/app_localizations.dart';
export './src/app_localizations_en.dart';
export './src/app_localizations_ru.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';


class LocaleStateNotifier extends Notifier<AppLocalizations> {
  bool _localeChanged = false;

  @override
  AppLocalizations build() {
    return AppLocalizationsEn();
  }

  bool get isLocaleChanged => _localeChanged;


  void setLocale(AppLocalizations newLocale) {
    state = newLocale;
    _localeChanged = true;
  }
}

final localeProvider =
NotifierProvider<LocaleStateNotifier, AppLocalizations>(LocaleStateNotifier.new);
