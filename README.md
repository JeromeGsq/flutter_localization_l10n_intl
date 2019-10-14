Flutter Intl localization with *.arb files
===============

**flutter_localizations package**: https://flutter.dev/docs/development/accessibility-and-localization/internationalization

**intl_translation package**: https://pub.dev/packages/intl_translation

**arb files**: https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification


Usage
===============
Create a new folder called `l10n` inside `lib`
Add your `*.arb` files inside `l10n`

Run this commands: 
```sh
> flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localization.dart 
> flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization.dart lib/l10n/intl_*.arb
```

You can use my custom `build-localization.sh` too:
```sh
// Don't forget to chmod
> ./build-localization.sh
```

• **files and folders**
```dart
Project
+-- lib
    +-- l10n
    |   |-- intl_en-GB.arb
    |   |-- intl_en-US.arb
    |   |-- intl_fr-FR.arb
    |   |-- intl_messages.arb
    |   |
    |   |-- messages_all.dart
    |   |-- messages_en_GB.dart
    |   |-- messages_en_US_.dart
    |   |-- messages_fr_FR_.dart
    |   +-- messages_messages.dart
    |
    |-- localization.dart
    +-- main.dart
```
• **intl_en-GB.arb**
- Configure your locale: `"@@locale":"en_GB"`
- Create your localization keys: `"title": "Hello world App from GB"`

```json
{
   "@@locale":"en_GB",
   "@@last_modified": "2018-05-25T11:50:40.743319",
   "title": "Hello world App from GB",
   "hello": "Hello",
 }
```

• **localization.dart**

Configure supported locales in `supportedLocales`
```dart
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
    Locale("fr", "FR"),
  ];
```

Insert keys manually at the end of `AppLocalizations`
```dart
  // Insert manually traductions keys below
  String get title => Intl.message('Hello world App', name: 'title');
  String get hello => Intl.message('Hello', name: 'hello');
}
```

• **main.dart**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configure localizationsDelegates with AppLocalizationsDelegate()
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // Provide supported locales
      supportedLocales: AppLocalizations.supportedLocales,
      // Provide startup locale
      localeResolutionCallback: AppLocalizations.getStartupLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Localization'),
    );
  }
}
```


• **Use key inside widget tree** 
```dart
Text(AppLocalizations.of(context).title),
```

• **Swap language** 
```dart
void _swapLanguage() {
  setState(() {
    AppLocalizations.load(Locale("fr", "FR"));
    // or
    AppLocalizations.load(AppLocalizations.supportedLocales[0]);
  });
}
```

Pro/Cons
===============
**Pros:**
- Support multiple language/country configurations (ex: `en-GB` and `en-US`)
- You can take advantage of the advantage of `*.arb` files and their configuration

**Cons:** 
- Work only with `*.arb` files
- You need to update manually `localization.dart` when you add/remove a new key
- You need to run mutilple command lines each time you add/remove a new key
