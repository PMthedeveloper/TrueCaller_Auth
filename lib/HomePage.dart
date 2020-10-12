import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truecaller_Auth/App.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Truecaller Auth"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              _firebaseAuth.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => App()));
            },
          ),
        ],
      ),
    );
  }
}
