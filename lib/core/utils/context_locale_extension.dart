import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get locale {
    var locale = AppLocalizations.of(this);
    return locale ?? AppLocalizationsEn();
  }
}
