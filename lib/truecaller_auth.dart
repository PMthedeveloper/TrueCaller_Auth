import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truecaller_Auth/Phone_Firebase_login.dart';
import 'package:truecaller_Auth/HomePage.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class TrueLogin extends StatefulWidget {
  @override
  _TrueLoginState createState() => _TrueLoginState();
}

class _TrueLoginState extends State<TrueLogin> {
  final _firestore = Firestore.instance;
  Stream<TruecallerSdkCallback> _stream;

  String email;
  String mobileno;
  String firstname;
  String lastname;

  @override
  void initState() {
    super.initState();
    _stream = TruecallerSdk.streamCallbackData;
    trueCaller(context);
  }

  trueCaller(context) {
    TruecallerSdk.initializeSDK(
      sdkOptions: TruecallerSdkScope.SDK_CONSENT_TITLE_GET_STARTED,
      consentMode: TruecallerSdkScope.CONSENT_MODE_POPUP,
      loginTextPrefix: TruecallerSdkScope.LOGIN_TEXT_PREFIX_TO_PROCEED,
      buttonShapeOptions: TruecallerSdkScope.BUTTON_SHAPE_ROUNDED,
      footerType: TruecallerSdkScope.FOOTER_TYPE_ANOTHER_METHOD,
    );
    TruecallerSdk.isUsable.then((isUsable) async {
      if (isUsable) {
        TruecallerSdk.setDarkTheme;
        TruecallerSdk.getProfile;
      } else {
        // print("Not usable");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PhoneLogin()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Truecaller Auth"),
          automaticallyImplyLeading: false,
        ),
        body: Material(
          child: StreamBuilder<TruecallerSdkCallback>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.result) {
                  case TruecallerSdkCallbackResult.success:
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    " ${snapshot.data.profile.firstName} ${snapshot.data.profile.lastName} \n ${snapshot.data.profile.email} \n ${snapshot.data.profile.phoneNumber}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        height: 3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: OutlineButton(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          style: BorderStyle.solid,
                                          width: 3),
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                        await _firestore
                                            .collection("true_users")
                                            .add({
                                              'email':
                                                  snapshot.data.profile.email,
                                              'mobileno': snapshot
                                                  .data.profile.phoneNumber,
                                              'firstname': snapshot
                                                  .data.profile.firstName,
                                              'lastname':
                                                  snapshot.data.profile.lastName
                                            })
                                            .then(
                                                (value) => print("User Added!"))
                                            .catchError((error) => print(
                                                "Failed to add user: $error"));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    break;
                  case TruecallerSdkCallbackResult.failure:
                    return PhoneLogin();
                    break;
                  case TruecallerSdkCallbackResult.verification:
                    return Text("Verification Required!");
                    break;
                  default:
                    return Text("Invalid result");
                }
              } else
                return PhoneLogin();
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
