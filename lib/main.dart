import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quote_acciona/src/pages/home_page.dart';
import 'package:quote_acciona/src/pages/login_page.dart';
import 'package:quote_acciona/src/pages/quote/list.dart';
import 'package:quote_acciona/src/pages/quote/new.dart';
import 'package:quote_acciona/src/providers/login_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', 'PE'),
          const Locale('en', 'US'),
        ],
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'quote.list': (BuildContext context) => ListPage(),
          'quote.new': (BuildContext context) => NewPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.redAccent
        ),
      ),
    );
  }
}