import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:truecaller_Auth/phone_auth.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: PhoneLogin(),
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
