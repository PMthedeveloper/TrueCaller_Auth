import 'package:flutter/material.dart';
import 'package:truecaller_Auth/Splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "True Auth",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Splash(),
    );
  }
}
