import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quiz extends StatefulWidget {
  final int snumber;
  Quiz({this.snumber});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  getAllQuestions() async {
    final getAllMonumentsEndpoint =
        'https://bharat-mystery-api.herokuapp.com/quiz?sno=${widget.snumber}';
    final response = await http.get(getAllMonumentsEndpoint);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

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

        return Scaffold(
          backgroundColor: Color(0xffA0E7E5),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: allQues.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Text(
                                    (allQues[index])["ques"],
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
                                    decoration: InputDecoration(
                                        hintText: "Answer",
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        contentPadding: EdgeInsets.all(17.0)),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          MaterialButton(
                            onPressed: () {},
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
