import 'package:bharat_mystery/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bharat_mystery/screens/register_screen.dart';
import 'package:bharat_mystery/screens/homepage.dart' as HomePage;
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String _forgotEmail;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //bharat mystery logo and image
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 70.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.network('https://i.imgur.com/W0fE4FL.png'),
                      ),
                      Text(
                        "Bharat Mystery",
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Color(0xffA0E7E5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      //login text
                      Text(
                        "Forgot Page",
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            //textfield email
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please provide an email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[50]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(20.0)),
                              onSaved: (input) => this._forgotEmail = input,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //don't have an account register.--useless
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //change page to register.--useless
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Don't have an account? Register",
                                    style: TextStyle(
                                        fontFamily: "LexendDeca",
                                        fontSize: 14.0,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            MaterialButton(
                              onPressed: forgotPassword,
                              height: 50.0,
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              shape: StadiumBorder(),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontFamily: 'LexendDeca',
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      //Forgot Password
      try {
        auth.sendPasswordResetEmail(email: this._forgotEmail);
        Fluttertoast.showToast(
            msg:
                'a forgot password email has been sent, please reset your password through it.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        //navigate to a new screen --change the screen below
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
        _forgotEmail = null;
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Incorrect Email or Email does not have an account',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }
  }
}
