import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class WebMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static double userLat =  0.0;
  static double userLon =  0.0;import 'dart:async';

  import 'package:flutter/material.dart';
  import 'package:geolocator/geolocator.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';

  const  kGoogleApiKey = "AIzaSyDO3Z02-fkDqQd8ZrzLAcElJsRl6e5v5NQ";

//GoogleMapsPlaces _places =  GoogleMapsPlaces(apiKey: kGoogleApiKey);

  void main() => runApp(MyApp());

  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Flutter Google Maps Demo',
  home: GetLocationPage(),
  );
  }
  }

  class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
  }

  class _GetLocationPageState extends State<GetLocationPage> {

  GoogleMapController mapController;
  Placemark currentAddress;
  Position userLocation;

  @override
  void initState() {
  super.initState();

  _getLocation().then((value){
  //print(value.altitude);

  userLocation = value;
  _getAddress(value).then((temp){

  currentAddress = temp;
  });

  setState(() { });
  });
  }

  Future<Position> _getLocation() async{
  Position temp = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  return temp;
  }

  Future<Placemark> _getAddress(location)  async{
  List<Placemark> placemark =  await Geolocator().placemarkFromCoordinates(userLocation.latitude, userLocation.longitude);
  var tempAddress = placemark[0];
  return tempAddress;
  }

  Widget build(BuildContext context) {
  if (userLocation == null) {
  return new Container(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
  color: Colors.amber,
  );
  }
  else {
  return Scaffold(
  appBar:

  AppBar(
  title:
  currentAddress == null
  ? Text("Unknown", textAlign: TextAlign.center)
      :
  Text(currentAddress.locality, textAlign: TextAlign.center),
  backgroundColor: Color.fromRGBO(255, 253, 208, 100),
  ),

  body:
  userLocation == null
  ? CircularProgressIndicator(backgroundColor: Colors.blueGrey)
      :
  Container(
  color: Color.fromRGBO(102, 0, 0, 100),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Container(
  height: 500,
  color: Color.fromRGBO(128, 0, 0, 100),
  child: GoogleMap(
  onMapCreated: (GoogleMapController _mapController) {
  mapController = _mapController;
  },
  initialCameraPosition: new CameraPosition(
  zoom: 13.0,
  target: LatLng(
  userLocation.latitude, userLocation.longitude)
  ),
  )
  ),
  ],
  ),
  ),
  floatingActionButton: FloatingActionButton(onPressed: () {
  _getLocation().then((value) {
  userLocation = value;
  //print(value.altitude);
  mapController.animateCamera(
  CameraUpdate.newCameraPosition(
  CameraPosition(
  target: LatLng(value.latitude, value.longitude),
  zoom: 13.0
  )
  )
  );
  _getAddress(value).then((temp) {
  currentAddress = temp;
  //print(currentAddress.locality);
  });
  });
  },
  child: const Icon(Icons.my_location, size: 36.0),
  ),
  );
  }
  }
  }



  /*Future<void> fetchData() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    userLat = position.latitude;
    userLon  = position.longitude;

    print(userLat);
    print(userLon);

    //return position;
  }*/

  static CameraPosition _location = CameraPosition(
  target: LatLng(userLat, userLon),
  zoom: 12);

  @override
  Widget build(BuildContext context) {
  return new Scaffold(

  body: GoogleMap(
  onMapCreated: (GoogleMapController controller) {
  _controller.complete(controller);
  },
  mapType: MapType.hybrid,
  myLocationEnabled: true,
  initialCameraPosition: _location,

  ),
  /*floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchData,
        label: Text('Find My Location!'),
        icon: Icon(Icons.directions_boat),
      ),*/
  );
  }

}
