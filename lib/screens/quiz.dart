import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  final int snumber;
  Quiz({this.snumber});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  getAllQuestions() async {
    final getAllMonumentsEndpoint =
        'https://bharat-mystery-api.herokuapp.com/quiz?sno=${widget.snumber}';
    final response = await http.get(getAllMonumentsEndpoint);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  String ans1;
  String ans2;
  String ans3;
  String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllQuestions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).focusColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final allQues = json.decode(snapshot.data);

        bool checkAns() {
          var totalScore = 0;
          if (ans1.toLowerCase() == allQues[0]["ans"].toLowerCase()) {
            totalScore++;
          }
          if (ans2.toLowerCase() == allQues[1]["ans"].toLowerCase()) {
            totalScore++;
          }
          if (ans3.toLowerCase() == allQues[2]["ans"].toLowerCase()) {
            totalScore++;
          }

          if (totalScore >= 2) {
            return true;
          } else {
            return false;
          }
        }

        Future<Void> testPassed() async {
          final prefs = await SharedPreferences.getInstance();
          uid = prefs.getString('GLOBAL_USER_DATA');

          Map<String, dynamic> mapTrue = {
            (widget.snumber + 1).toString(): true
          };

          await users
              .doc(uid.toString())
              .collection((widget.snumber + 1).toString())
              .doc((widget.snumber + 1).toString())
              .set(mapTrue);
        }

        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Quiz Time",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              fontSize: 27.0,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).highlightColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          //ques 1
                          Text(
                            (allQues[0])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Theme.of(context).highlightColor),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          //answer field
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (val) {
                              setState(() {
                                ans1 = val;
                              });
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Please enter the answer' : null,
                            decoration: InputDecoration(
                                hintText: "Answer",
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: EdgeInsets.all(17.0)),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          //ques 2
                          Text(
                            (allQues[1])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Theme.of(context).highlightColor),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          //answer field
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (val) {
                              setState(() {
                                ans2 = val;
                              });
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Please enter the answer' : null,
                            decoration: InputDecoration(
                                hintText: "Answer",
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: EdgeInsets.all(17.0)),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          //ques3
                          Text(
                            (allQues[2])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Theme.of(context).highlightColor),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          //answer field
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (val) {
                              setState(() {
                                ans3 = val;
                              });
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Please enter the answer' : null,
                            decoration: InputDecoration(
                                hintText: "Answer",
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: EdgeInsets.all(17.0)),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //submit button
                          MaterialButton(
                            onPressed: () {
                              final formState = _formKey.currentState;
                              if (formState.validate()) {
                                formState.save();

                                if (checkAns()) {
                                  // Remove this and add Unlocking code and then add the toast that next monument has been unlocked then pop the screen
                                  Fluttertoast.showToast(
                                      msg: 'Test Passed',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                  testPassed();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "You need atleast 2 answers correct to unlock the next monument, please check spelling's too",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                }
                              }
                            },
                            height: 50.0,
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            shape: StadiumBorder(),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  fontSize: 16.0,
                                  color: Theme.of(context).cardColor),
                            ),
                            color: Theme.of(context).highlightColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
