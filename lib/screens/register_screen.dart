import 'package:bharat_mystery/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _registerName, _registerEmail, _registerPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _passwordVisible = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //logo and bharat mystery text
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    //logo bharat mystery
                    Container(
                      child: Image.network('https://i.imgur.com/W0fE4FL.png'),
                    ),
                    //text bharat mystery
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
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
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
                    //register text
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Register",
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
                            //name
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              onSaved: (input) => _registerName = input,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please provide an name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[50]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(20.0)),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //email
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please provide an email';
                                }
                                return null;
                              },
                              onSaved: (input) => _registerEmail = input,
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
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //password
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
                              onSaved: (input) => _registerPassword = input,
                              obscureText: this._passwordVisible,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: this._passwordVisible
                                          ? Colors.blue
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
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //already have an account login --useless
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginPage()));
                                    },
                                    child: Text(
                                      "Already have an account? Login",
                                      style: TextStyle(
                                          fontFamily: 'LexendDeca',
                                          fontSize: 14.0,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),

                    //register button
                    MaterialButton(
                      onPressed: registerUser,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "Register",
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

  Future<void> registerUser() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      //Register FIREBASE AUTH and send email verification
      try {
        //create a user.
        User user = (await auth.createUserWithEmailAndPassword(
                email: _registerEmail, password: _registerPassword))
            .user;

        //user verification by email
        user.sendEmailVerification();

        //get current date and time
        DateTime now = DateTime.now();
        String _formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

        //create a map with name email and registration date
        Map<String, dynamic> userData = {
          "name": this._registerName,
          "email": this._registerEmail,
          "registered_On": _formattedDate
        };
        //upload the map
        users.doc(user.uid).set(userData);
        Fluttertoast.showToast(
            msg: "email verification send, please verify " + _registerName);
        _registerEmail = null;
        _registerPassword = null;
        _registerName = null;
        Fluttertoast.showToast(
            msg: 'Registered successfully, please login',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        //change user screen so that he can login
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      } catch (e) {
        print("some shit happened in login screen heres a report " + e.message);
        Fluttertoast.showToast(
            msg: 'Registeration Failed, please try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }
  }
}
