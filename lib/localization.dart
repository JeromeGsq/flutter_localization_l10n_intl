import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  // You need to configure supported locales here
  // You need to configure Info.plist too
  //
  // The order of this list matters. By default, if the
  // device's locale doesn't exactly match a locale in
  // supportedLocales then the first locale in
  // supportedLocales with a matching
  // Locale.languageCode is used. If that fails then the
  // first locale in supportedLocales is used.
  static const supportedLocales = [
    Locale("en", "US"),
    Locale("en", "GB"),
    Locale("es", "ES"),
    Locale("fr", "FR"),
  ];

  static Future<AppLocalizations> load(Locale locale) {
    assert(locale != null);

    final String name = locale.countryCode == null ? locale?.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Locale getStartupLocale(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale?.languageCode == locale?.languageCode && supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  // Insert manually traductions keys below
  String get title => Intl.message('Hello world App', name: 'title');
  String get hello => Intl.message('Hello', name: 'hello');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
