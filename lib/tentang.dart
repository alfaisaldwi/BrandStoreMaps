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
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
         
          SizedBox(
            height: 20,
          ),
          Text('Aplikasi BrandingMaps - Hastuti Romdhona'),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              child: Text('Kontributor'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
          )
        ]),
      ),
    );
  }
}
