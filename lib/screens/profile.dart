import 'package:bharat_mystery/main.dart';
import 'package:bharat_mystery/screens/login.dart';
import 'package:bharat_mystery/screens/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String uid, userName = "user", verified = "not verified";
  bool senvermail = true;

  @override
  void initState() {
    super.initState();
    _asyncMethodInnitState();
  }

  //god this was hell, wasted like 3 hours, trying to update the name of the user, after welcome.
  void _asyncMethodInnitState() async {
    await getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
    await getUserVerified().then((value) {
      setState(() {
        verified = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    super.build(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  20.0, 300.0, 20.0, 0), //text username
              child: Column(
                children: <Widget>[
                  new Text(
                    "Welcome $userName",
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontFamily: 'LexendDeca',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  //text of verification status
                  new Text(
                    "Verification Status: $verified",
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontFamily: 'LexendDeca',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //visibilty so that if user is verified, the verification mail is not seen again and again
                  Visibility(
                      visible: senvermail,
                      child: TextButton(
                          onPressed: sendUserVerificationMail,
                          child: Text(
                            "Send verification mail again?",
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 14.0,
                                color: Theme.of(context).highlightColor),
                          ))),

                  //switchlisttile switch
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) => SwitchListTile(
                            title: Text("Dark Mode"),
                            onChanged: (value) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: Text('This will restart the app?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => {
                                        notifier.toggleTheme(),
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MyApp()),
                                            (route) => false)
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            value: notifier.darkTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //logout button
                  MaterialButton(
                    onPressed: logoutUser,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: StadiumBorder(),
                    child: Text(
                      "Logout",
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
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 20.0,
                color: Theme.of(context).focusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //get user's verification status
  Future<String> getUserVerified() async {
    String _verfy;
    User user = FirebaseAuth.instance.currentUser;
    if (user.emailVerified == true) {
      _verfy = "Verified";
      senvermail = false;
    } else {
      _verfy = "Not Verified";
      senvermail = true;
    }
    return _verfy;
  }

  // get's user's name.
  Future<String> getUserName() async {
    String _username;
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('GLOBAL_USER_DATA');
    await users.doc(uid.toString()).get().then((documentSnapshot) {
      _username = documentSnapshot.data()['name'].toString();
    });
    return _username;
  }

  //logs user's out
  Future<void> logoutUser() async {
    //logout user
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GLOBAL_USER_DATA', null);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }

  //send user verification mail
  Future<void> sendUserVerificationMail() async {
    User user = FirebaseAuth.instance.currentUser;
    user.sendEmailVerification().catchError((e) {
      Fluttertoast.showToast(
          msg: "verification mail failed to be sent" + e.toString());
    });
    Fluttertoast.showToast(msg: "verification mail sent");
  }

  @override
  // wantKeepAlive
  bool get wantKeepAlive => true;
}
