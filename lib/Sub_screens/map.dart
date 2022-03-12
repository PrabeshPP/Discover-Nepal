import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final String address;
  const MapPage({
    Key? key,
    required this.address,
  }) : super(key: key);

  get name => null;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double? Lat;
  double? Long;
  double? MyLat;
  double? MyLong;
  bool havevalue = true;
  Position? currentposition;

  Future<Position?> _determinePosition() async {
    bool? _serviceEnabled;
    LocationPermission permission;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      VxToast.show(context,
          msg: "You have not granted location permission to the user!");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        VxToast.show(context, msg: "Please turn your location on");
      }
    }
    if (permission == LocationPermission.denied) {
      VxToast.show(context, msg: "Denied forever");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      currentposition = position;
      MyLat = currentposition!.latitude;
      MyLong = currentposition!.longitude;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState()  {
    super.initState();
     latlong();
  }

  latlong() async {
    final locations = await locationFromAddress(widget.address);
    Lat = locations[0].latitude;
    Long = locations[0].longitude;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Lat = Lat;
    Long = Long;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: "Map".text.color(Colors.black).make(),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _determinePosition();

            setState(() {});
          },
          clipBehavior: Clip.antiAlias,
          child: Icon(Icons.location_searching_sharp),
        ),
        body: (Lat != null && Long != null)
            ? FlutterMap(
                options: MapOptions(
                  center: LatLng.LatLng(Lat!, Long!),
                  zoom: 12.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/prabeshbista/cks5gfmmq8mnr18p61ounbsnd/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicHJhYmVzaGJpc3RhIiwiYSI6ImNrczRsNzg4ZzFjbHIycHFtcDVubXU4bGgifQ.hCkuxiz0NEpffaUpOMTWDA",
                      additionalOptions: {
                        "accessToken":
                            "pk.eyJ1IjoicHJhYmVzaGJpc3RhIiwiYSI6ImNrczRsNzg4ZzFjbHIycHFtcDVubXU4bGgifQ.hCkuxiz0NEpffaUpOMTWDA",
                        "id": "mapbox.mapbox-streets-v8",
                      }),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 100.0,
                        height: 100.0,
                        point: LatLng.LatLng(Lat!, Long!),
                        builder: (ctx) => Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                      if (MyLat != null && MyLong != null)
                        Marker(
                            point: LatLng.LatLng(MyLat!, MyLong!),
                            builder: (context) => Icon(
                                  CupertinoIcons.largecircle_fill_circle,
                                  color: Colors.blue,
                                  size: 20,
                                ))
                    ],
                  ),
                ],
              )
            : Center(child: 
            CircularProgressIndicator()));
  }
}
