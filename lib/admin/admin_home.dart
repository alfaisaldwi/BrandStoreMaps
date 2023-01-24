import 'package:brand_maps/admin/halaman_list_marker.dart';
import 'package:brand_maps/controller/login_controller.dart';
import 'package:brand_maps/maps_page.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Halaman Admin'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                child: Text('Kelola Lokasi'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListMarkerPage()));
                }),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                AuthService().asignOutUser();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMapPage(),
                    ));
              },
            )
          ]),
        ),
      ),
    );
  }
}
