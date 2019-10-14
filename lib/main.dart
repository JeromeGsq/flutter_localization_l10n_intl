import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'localization.dart';

void main() => runApp(MyApp());

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Swap locale at runtime
  int localIndex = 0;
  void _switchLanguage() {
    setState(() {
      localIndex = localIndex >= AppLocalizations.supportedLocales.length - 1 ? 0 : localIndex + 1;
      AppLocalizations.load(AppLocalizations.supportedLocales[localIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Localizations.localeOf(context) will return the application locale from the OS.
            // It won't change at runtime
            Text("App start locale: ${Localizations.localeOf(context)}"),

            // You can change in app localization by code
            // Intl will return the current in app locale
            Text("Current locale from Intl: ${Intl.defaultLocale}"),

            // Display title with the correct locale
            Text(AppLocalizations.of(context).title),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchLanguage,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}
