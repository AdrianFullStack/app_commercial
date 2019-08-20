import 'package:flutter/material.dart';
import 'package:quote_acciona/src/pages/home_page.dart';
import 'package:quote_acciona/src/pages/login_page.dart';
import 'package:quote_acciona/src/providers/login_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}