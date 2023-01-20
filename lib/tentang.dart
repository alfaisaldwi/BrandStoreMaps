import 'package:brand_maps/admin/halaman_list_marker.dart';
import 'package:brand_maps/login.dart';
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
            child: ListView(
              children: [
                GestureDetector(
                    child: Text('Kelola Lokasi'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListMarkerPage()));
                    }),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('login'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          )
        ]),
      ),
    );
  }
}
