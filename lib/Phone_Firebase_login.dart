import 'package:flutter/material.dart';
import 'package:truecaller_Auth/otp_screen.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    if (_phoneNumberController.text.length == 10) {
      updateState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      alignment: Alignment.bottomCenter,
      child: Card(
        shadowColor: Colors.grey,
        elevation: 1,
        margin: const EdgeInsets.only(top: 40),
        child: Builder(
          builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.7,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  Text(
                    'Login/Create Account',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      autofocus: true,
                      onChanged: (text) {
                        validate(state);
                      },
                      decoration: InputDecoration(
                        labelText: "10 digit mobile number",
                        prefix: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "+91 | ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      autovalidate: true,
                      autocorrect: false,
                      maxLengthEnforced: true,
                      validator: (value) {
                        return !isValid
                            ? 'Please provide a valid 10 digit phone number'
                            : null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: RaisedButton(
                          color: !isValid
                              ? Theme.of(context).primaryColor.withOpacity(0.5)
                              : Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            !isValid ? "ENTER PHONE NUMBER" : "CONTINUE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (isValid) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPScreen(
                                      mobileNumber: _phoneNumberController.text,
                                    ),
                                  ));
                            } else {
                              validate(state);
                            }
                          },
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
