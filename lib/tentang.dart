import 'package:brand_maps/admin/admin_home.dart';
import 'package:brand_maps/admin/halaman_list_marker.dart';
import 'package:brand_maps/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TentangPage extends StatefulWidget {
  const TentangPage({Key? key}) : super(key: key);

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Aplikasi BrandingMaps - Hastuti Romdhona untuk PT Sanghiang Perkasa (Kalbe Nutritional)',textAlign: TextAlign.center,),
              )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen),
                      child: Text('Admin'),
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHome(),
                              ));
                        }
                      }),
                ),
              )
            ]),
      ),
    );
  }
}
