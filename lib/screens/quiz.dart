import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Quiz extends StatefulWidget {
  final int snumber;
  Quiz({this.snumber});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllQuestions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xffA0E7E5),
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

        return Scaffold(
          backgroundColor: Color(0xffA0E7E5),
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
                              color: Colors.black),
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
                          Text(
                            (allQues[0])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
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
                          Text(
                            (allQues[1])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
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
                          Text(
                            (allQues[2])["ques"],
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
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
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'You need atleast 2 answers correct to unlock the next monument',
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
                                  color: Colors.white),
                            ),
                            color: Colors.black,
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
