import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/chim2/ckleuvk5n65ak17pnwxgoyo7l/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hpbTIiLCJhIjoiY2tsZXBjOWI1MTJvczJ2bWpiZWE5azNlNyJ9.-LB_CjjYIksqNZTdiSmFNg",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiY2hpbTIiLCJhIjoiY2tsZXBjOWI1MTJvczJ2bWpiZWE5azNlNyJ9.-LB_CjjYIksqNZTdiSmFNg',
                'id': ''
              },
            ),
          ],
        ),
      ),
    );
  }
}
