import 'package:flutter/material.dart';
import 'package:truecaller_Auth/Bottombar.dart';
import 'package:truecaller_Auth/HomePage.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  Stream<TruecallerSdkCallback> _stream;

  @override
  void initState() {
    trueCaller(context);
    super.initState();
    _stream = TruecallerSdk.streamCallbackData;
  }

  trueCaller(context) {
    TruecallerSdk.initializeSDK(
        sdkOptions: TruecallerSdkScope.SDK_CONSENT_TITLE_GET_STARTED,
        consentMode: TruecallerSdkScope.CONSENT_MODE_POPUP,
        loginTextPrefix: TruecallerSdkScope.LOGIN_TEXT_PREFIX_TO_PROCEED,
        buttonShapeOptions: TruecallerSdkScope.BUTTON_SHAPE_ROUNDED,
        footerType: TruecallerSdkScope.FOOTER_TYPE_ANOTHER_METHOD);
    TruecallerSdk.isUsable.then((isUsable) async {
      if (isUsable) {
        TruecallerSdk.setDarkTheme;
        TruecallerSdk.getProfile;
      } else {
        print("Not usable");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Truecaller Auth"),
        ),
        body: Material(
          child: StreamBuilder<TruecallerSdkCallback>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.result) {
                  case TruecallerSdkCallbackResult.success:
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                              " ${snapshot.data.profile.firstName} ${snapshot.data.profile.lastName} \n ${snapshot.data.profile.email} \n ${snapshot.data.profile.phoneNumber}",
                              style: TextStyle(
                                  fontSize: 20, letterSpacing: 2, height: 5)),
                          // OutlineButton(
                          //     borderSide: BorderSide(
                          //         color: Colors.blue,
                          //         style: BorderStyle.solid,
                          //         width: 3),
                          //     child: Text(
                          //       'Log out',
                          //       style: TextStyle(color: Colors.blue),
                          //     ),
                          //     onPressed: () {
                          //       FirebaseAuth.instance
                          //           .signOut()
                          //           .then((action) {
                          //         Navigator.of(context)
                          //             .pushReplacementNamed('/homepage');
                          //       }).catchError((e) {
                          //         print(e);
                          //       });
                          //     }),
                          OutlineButton(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 3),
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  case TruecallerSdkCallbackResult.failure:
                    return BottomBar();
                  case TruecallerSdkCallbackResult.verification:
                    return Text("Verification Required!");
                  default:
                    return Text("Invalid result");
                }
              } else
                return BottomBar();
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}