import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];


  static final CameraPosition _bside = CameraPosition(
    target: LatLng(37.49565610362972, 127.03884620670416),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(_markers),
        onTap: (location){click(location);},
        initialCameraPosition: _bside,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  click(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
          Marker(
              position: latLng,
              markerId: MarkerId("1"),
              infoWindow: InfoWindow(
                  title: latLng.latitude.toString(),
                  snippet: latLng.longitude.toString()
              )
          )
      );
    });
  }
}