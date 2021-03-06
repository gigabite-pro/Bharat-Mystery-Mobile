import 'package:bharat_mystery/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => getAllMonuments());
  // }

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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 30.0),
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
                height: MediaQuery.of(context).size.height * 0.7,
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
                      //register text
                      Text(
                        "Register",
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
                            //name
                            TextFormField(
                              autocorrect: false,
                              autofocus: false,
                              onSaved: (input) => _registerName = input,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please provide a name';
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
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            //already have an account login --useless
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
                                            LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Already have an account? Login",
                                    style: TextStyle(
                                        fontFamily: "LexendDeca",
                                        fontSize: 14.0,
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
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

  // var allMonuments;

  // getAllMonuments() async {
  //   final getAllMonumentsEndpoint =
  //       'https://bharat-mystery-api.herokuapp.com/allmonuments';
  //   final response = await http.get(getAllMonumentsEndpoint);
  //   if (response.statusCode == 200) {
  //     allMonuments = json.decode(response.body);
  //     print(allMonuments);
  //   }
  //   allMonuments = null;
  // }

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

        // Map _levels = {};
        // for (var i = 1; i < allMonuments.length + 1; i++) {
        //   if (i == 1) {
        //     _levels[i] = true;
        //   } else {
        //     _levels[i] = false;
        //   }
        // }

        //create a map with name email and registration date
        Map<String, dynamic> userData = {
          "name": this._registerName,
          "email": this._registerEmail,
          "registered_On": _formattedDate,
          // "levels": _levels,
        };
        //upload the map
        users.doc(user.uid).set(userData);
        Fluttertoast.showToast(
            msg: "email verification sent, please verify " + _registerName);
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
