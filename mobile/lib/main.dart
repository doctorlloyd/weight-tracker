import 'package:flutter/material.dart';
import 'package:mobile/ui/home.dart';
import 'package:mobile/ui/login.dart';
import 'package:mobile/ui/register.dart';

void main() {
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  '/': (context) => Login(),
  '/home': (context) => Home(),
  '/register': (context) => Register(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight tracker',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}