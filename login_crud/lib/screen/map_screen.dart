import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_crud/util/my_location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:uuid/uuid.dart';

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
    return Stack(
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * .65,
          color: Color(0xFF262626),
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
        ),
        Positioned(
          left: 20.0,
          top: 20.0,
          child: FloatingActionButton(
            child: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/search'),
            backgroundColor: Colors.white70,
          ),
        ),
      ],
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
      _text1 = "Lat : " + _markers["test"]!.position.latitude.toString();
      _text2 = "Lnt : " + _markers["test"]!.infoWindow.snippet!;
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
              height: 24.0,
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

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({Key? key})
      : super(
    key: key,
    apiKey: dotenv.get('GOOGLE_APP_KEY'),
    sessionToken: const Uuid().v4(),
    language: 'ko',
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarPlacesAutoCompleteTextField(
          textStyle: null,
          textDecoration: null, cursorColor: null,
        ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) => displayPrediction(p, context),
        logo: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [FlutterLogo()],
        ),
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage ?? 'Unknown error')),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);

    if (response.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Got answer')),
      );
    }
  }
}

Future<void> displayPrediction(
    Prediction? p, BuildContext context) async {
  if (p == null) {
    return;
  }

  // get detail (lat/lng)
  final _places = GoogleMapsPlaces(
    apiKey: dotenv.get('GOOGLE_APP_KEY'),
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );

  final detail = await _places.getDetailsByPlaceId(p.placeId!);
  final geometry = detail.result.geometry!;
  final lat = geometry.location.lat;
  final lng = geometry.location.lng;
  print('${p.description} - $lat/$lng');
  Navigator.pop(context, true);
}