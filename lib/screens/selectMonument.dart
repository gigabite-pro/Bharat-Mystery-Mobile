import 'dart:convert';
import 'package:bharat_mystery/main.dart';
import 'package:bharat_mystery/screens/monument.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SelectMonument extends StatefulWidget {
  SelectMonument({Key pagekey, this.title}) : super(key: pagekey);
  final String title;

  @override
  _SelectMonumentState createState() => _SelectMonumentState();
}

class _SelectMonumentState extends State<SelectMonument>
    with AutomaticKeepAliveClientMixin {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //exit app on back pressed
    return WillPopScope(onWillPop: _onWillPop, child: SelectMonumentContent());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SelectMonumentContent extends StatefulWidget {
  @override
  _SelectMonumentContentState createState() => _SelectMonumentContentState();
}

class _SelectMonumentContentState extends State<SelectMonumentContent> {
  getAllMonuments() async {
    final getAllMonumentsEndpoint =
        'https://bharat-mystery-api.herokuapp.com/allmonuments';
    final response = await http.get(getAllMonumentsEndpoint);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllMonuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final allmonuments = json.decode(snapshot.data);

          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    child: ListView.builder(
                      itemCount: allmonuments
                          .length, // response from db <List of dicts>(json decoded)
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.place,
                                color: Theme.of(context).highlightColor),
                            title: Text((allmonuments[index])["name"],
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor)),
                            tileColor: Theme.of(context).cardColor,

                            // name property of indexed monument
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Monument(
                                      snumber: (allmonuments[index])["Snumber"],
                                    ),
                                  ));
                            },
                          ),
                        );
                      },
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
        });
  }
}
