import 'package:bharat_mystery/screens/forgot.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bharat_mystery/screens/register.dart';
import 'package:bharat_mystery/screens/homepage.dart' as HomePage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginEmail, _loginPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //bharat mystery logo and image
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 60.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: CachedNetworkImage(
                            imageUrl: "https://i.imgur.com/9JCxapv.png",
                            height: MediaQuery.of(context).size.height * 0.27,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                        Text(
                          "Bharat Mystery",
                          style: TextStyle(
                            color: Colors.black,
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
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.62,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
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
                                  return 'Please provide a password';
                                } else if (input.length < 6) {
                                  return 'Password needs to be atleast 6 digits';
                                }
                                return null;
                              },
                              obscureText: this._passwordVisible,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: this._passwordVisible
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() => this._passwordVisible =
                                          !this._passwordVisible);
                                    },
                                  ),
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
                              height: 5.0,
                            ),

                            //forgot password--useless
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ForgotPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontFamily: 'LexendDeca',
                                          fontSize: 13.0,
                                          color:
                                              Theme.of(context).highlightColor),
                                    ),
                                  ),
                                ),
                              ],
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
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
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
                                    color: Theme.of(context).cardColor),
                              ),
                              color: Theme.of(context).highlightColor,
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

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      //LOGIN FIREBASE AUTH
      try {
        User user = (await auth.signInWithEmailAndPassword(
                email: _loginEmail, password: _loginPassword))
            .user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('GLOBAL_USER_DATA', user.uid);
        //navigate to a new screen --change the screen below
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage.HomePage()),
            (Route<dynamic> route) => false);
        _loginEmail = null;
        _loginPassword = null;
      } catch (e) {
        print("some shit happened in login screen heres a report " + e.message);
        Fluttertoast.showToast(
            msg: 'Incorrect Email or Password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }
  }
}
