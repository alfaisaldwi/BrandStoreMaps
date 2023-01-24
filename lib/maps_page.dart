import 'package:brand_maps/tentang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  static const double _defaultLat = -6.723512;
  static const double _defaultLong = 108.560025;
  late GoogleMapController myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static const CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(_defaultLat, _defaultLong), zoom: 15);
  MapType _currentMode = MapType.normal;
  final Set<Marker> _point = {};

  void _changeMode() {
    setState(() {
      _currentMode =
          _currentMode == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _addPoint() {
    setState(() {
      _point.add(Marker(
          markerId: MarkerId('defauktLocation'),
          position: _defaultLocation.target,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Coffee', snippet: 'Hidden Gems')));
    });
  }

  // Future<void> _moveCamera() async {
  //   const _newPosition = LatLng(40.7128, -74.0060);
  //   _googleMapController
  //       .animateCamera(CameraUpdate.newLatLngZoom(_newPosition, 15));
  //   setState(() {
  //     const point = Marker(
  //         markerId: MarkerId('newLocation'),
  //         position: _newPosition,
  //         infoWindow: InfoWindow(title: 'New Y', snippet: 'Bessstt'));
  //     _point
  //       ..clear()
  //       ..add(point);
  //   });
  // }

  Future<void> _goDefaultLocation() async {
    const _defaultPosition = LatLng(_defaultLat, _defaultLong);
    myController
        .animateCamera(CameraUpdate.newLatLngZoom(_defaultPosition, 15));
    setState(() {
      final point = Marker(
        markerId: MarkerId('Lokasi Awal'),
        position: _defaultPosition,
        infoWindow: InfoWindow(title: 'Lokasi Awal', snippet: 'ii'),
      );
      _point
        ..clear()
        ..add(point);
    });
  }

  void initMarker(specify, specifyId) async {
    if (specify['type'] == 'Toko') {
      Future<Uint8List> getBytesFromAsset(String path, int width) async {
        ByteData data = await rootBundle.load(path);
        ui.Codec codec = await ui.instantiateImageCodec(
            data.buffer.asUint8List(),
            targetWidth: width);
        ui.FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
      }

      final Uint8List markerIcon =
          await getBytesFromAsset('assets/image/toko.png', 120);

      var markerIdVal = specifyId;
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(
            title: '${specify['type']} - ${specify['titleT']}',
            snippet: '${specify['snippset']}'),
      );
      setState(() {
        markers[markerId] = marker;
      });
    } else {
      Future<Uint8List> getBytesFromAsset(String path, int width) async {
        ByteData data = await rootBundle.load(path);
        ui.Codec codec = await ui.instantiateImageCodec(
            data.buffer.asUint8List(),
            targetWidth: width);
        ui.FrameInfo fi = await codec.getNextFrame();
        return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
      }

      final Uint8List markerIcon =
          await getBytesFromAsset('assets/image/brand.png', 140);
      var markerIdVal = specifyId;
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(
            title: '${specify['type']} - ${specify['titleT']}',
            snippet: '${specify['snippset']}'),
      );
      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  getMarkerData() async {
    FirebaseFirestore.instance
        .collection('databaseMaps')
        .get()
        .then((myMockData) {
      if (myMockData.docs.isNotEmpty) {
        for (int i = 0; i < myMockData.docs.length; i++) {
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
        }
      } else {
        print(
            '--------------------------------------------eorororeoreqw--------');
      }
    });
  }

  @override
  void initState() {
    getMarkerData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('Shop'),
            position: LatLng(-6.723512, 108.560025),
            infoWindow: InfoWindow(title: 'soop'),
            icon: BitmapDescriptor.defaultMarker),
      ].toSet();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Stack(
          children: [
            Text(
              'Branding Maps',
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.black54,
              ),
            ),
            Text(
              'Branding Maps',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu), //don't specify icon if you want 3 dot menu
            color: Colors.white,
            itemBuilder: (context) => [
              // const PopupMenuItem<int>(
              //   value: 0,
              //   child: Text(
              //     "Setting",
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Tentang",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
        ],
      ),
      body: Stack(children: [
        GoogleMap(
          markers: Set<Marker>.of(markers.values),
          initialCameraPosition: _defaultLocation,
          mapType: _currentMode,
          onMapCreated: (GoogleMapController controller) {
            myController = controller;
          },
        ),
        Positioned(
          right: 10,
          bottom: 100,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(top: 24, right: 12),
            child: Column(children: [
              FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                onPressed: _changeMode,
                child: Icon(Icons.map, size: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.deepPurpleAccent,
              //   onPressed: _addPoint,
              //   child: Icon(Icons.add_location_alt, size: 30),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // FloatingActionButton(
              //   backgroundColor: Colors.yellowAccent,
              //   onPressed: _moveCamera,
              //   child: Icon(Icons.location_city, size: 30),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: _goDefaultLocation,
                child: Icon(Icons.location_on_outlined, size: 30),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => SettingPage()));
      break;
    case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TentangPage(),
          ));

      break;
  }
}
