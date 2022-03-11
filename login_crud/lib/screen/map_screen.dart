import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_crud/util/my_location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  bool _isLocation = false;

  String _text1 = "";
  String _text2 = "";

  CameraPosition _defaultPosition = const CameraPosition(
    target: LatLng(37.49565610362972, 127.03884620670416),
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    getPosition();
  }

  getPosition() async {
    Position position = await determinePosition();
    _defaultPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 17
    );
    setState(() {
      _isLocation = true;
    });
    //  기기의 현 위치로 이동
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_defaultPosition));
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Colors.black87,
      parallaxEnabled: true,
      backdropEnabled: true,  //  onPanel - body 흐리게
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      body: GoogleMap(
        myLocationEnabled: _isLocation,
        mapType: MapType.normal,
        markers: _markers.values.toSet(),
        onTap: (location) => _mapOnTab(location),
        initialCameraPosition: _defaultPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      panelBuilder: (sc) => _panel(sc),
    );
  }

  _mapOnTab(LatLng latLng) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("test"),
        position: LatLng(latLng.latitude, latLng.longitude),
        infoWindow: InfoWindow(
          title: latLng.latitude.toString(),
          snippet: latLng.longitude.toString(),
        ),
      );
      _markers["test"] = marker;
      setState(() {
        _text1 = "Lat : " + _markers["test"]!.position.latitude.toString();
        _text2 = "Lnt : " + _markers["test"]!.infoWindow.snippet!;
      });
    });
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "클릭된 마커정보",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Popular", Icons.favorite, Colors.blue),
                _button("Food", Icons.restaurant, Colors.red),
                _button("Events", Icons.event, Colors.amber),
                _button("More", Icons.more_horiz, Colors.green),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Images",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                        "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                        height: 120.0,
                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                        fit: BoxFit.cover,
                      ),
                      CachedNetworkImage(
                        imageUrl:
                        "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                        height: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("위치 정보",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(_text1 + "\n" + _text2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
          BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }
}