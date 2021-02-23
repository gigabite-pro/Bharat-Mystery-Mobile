import 'dart:ui';

import 'package:flutter/material.dart';

class SelectMonument extends StatefulWidget {
  @override
  _SelectMonumentState createState() => _SelectMonumentState();
}

class _SelectMonumentState extends State<SelectMonument>
    with AutomaticKeepAliveClientMixin {
  List<String> _places = [
    'Ajanta and Ellora Caves',
    'Gateway of India',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
    'Hawa Mahal',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xffA0E7E5),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.place),
                      title: Text(_places[index]),
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
                color: Color(0xffA0E7E5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
