import 'package:bharat_mystery/screens/monument.dart' as Monument;
import 'package:bharat_mystery/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

//statefull widget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginContent());
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  String _loginEmail, _loginPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //bharat mystery text and logo--useless
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Text(
                      "Bharat Mystery",
                      style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //bharat mystery text ends.

              Container(
                //other ui--useless
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffA0E7E5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    //login text--useless
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            //textfield email
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'please provide an email';
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
                              onSaved: (input) => _loginEmail = input,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //textfield password
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'please provide a password';
                                } else if (input.length < 6) {
                                  return 'your password needs to be atleast 6 digits';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[50]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(20.0)),
                              onSaved: (input) => _loginPassword = input,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //forgot password--not-working
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontFamily: 'LexendDeca',
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //don't have an account register.--useless
                            Row(
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
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //login button
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      onPressed: signIn,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: 'LexendDeca',
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      //LOGIN FIREBASE AUTH
      try {
        await auth.signInWithEmailAndPassword(
            email: _loginEmail, password: _loginPassword);
        //navigate to a new screen --change the screen below
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Monument.Monument(),
            ));
        _loginEmail = null;
        _loginPassword = null;
      } catch (e) {
        print("some shit happened in login screen heres a report " + e.message);
        Fluttertoast.showToast(
            msg: 'please check your email and password again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }
  }
}
