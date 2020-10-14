import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:truecaller_Auth/HomePage.dart';
import 'package:truecaller_Auth/truecaller_auth.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: user != null ? HomePage(user: user) : TrueLogin(),
      title: new Text(
        'True Auth',
        textScaleFactor: 2,
      ),
      image: Image.network(
          "https://t3.ftcdn.net/jpg/01/39/64/10/240_F_139641023_8I3Y8ifW4XGWTChsJtghqoeJIH7eCc6B.jpg"),
      loadingText: Text("Loading..."),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
