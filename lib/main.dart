import 'package:engram/screens/about.dart';
import 'package:engram/screens/home.dart';
import 'package:engram/utilities/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Home.id: (context) => Home(),
        About.id: (context) => About(),
      },
      initialRoute: Home.id,
      theme: kAppTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
