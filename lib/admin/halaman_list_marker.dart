import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMarkerPage extends StatefulWidget {
  ListMarkerPage({Key? key}) : super(key: key);

  @override
  State<ListMarkerPage> createState() => _ListMarkerPageState();
}

class _ListMarkerPageState extends State<ListMarkerPage> {
  final _fireStore = FirebaseFirestore.instance.collection('databaseMaps');
  final _fireAuth = FirebaseAuth.instance;
  TextEditingController titleC = TextEditingController();
  TextEditingController typeC = TextEditingController();
  TextEditingController snippsetC = TextEditingController();
  TextEditingController lattC = TextEditingController();
  TextEditingController longC = TextEditingController();

  final CollectionReference dbMaps =
      FirebaseFirestore.instance.collection('databaseMaps');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      titleC.text = documentSnapshot['titleT'];
      typeC.text = documentSnapshot['type'];
      snippsetC.text = documentSnapshot['snippsetT'];
      lattC.text = documentSnapshot['lattT'];
      longC.text = documentSnapshot['longT'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleC,
                  decoration: const InputDecoration(labelText: 'Nama Tempat'),
                ),
                TextField(
                  controller: typeC,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Tempat',
                  ),
                ),
                TextField(
                  controller: snippsetC,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan Tempat',
                  ),
                ),
                TextField(
                  controller: lattC,
                  decoration: const InputDecoration(
                    labelText: 'Lattitude',
                  ),
                ),
                TextField(
                  controller: longC,
                  decoration: const InputDecoration(
                    labelText: 'Longtitude',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? titleT = titleC.text;
                    final String? type = typeC.text;
                    final String? snippsetT = snippsetC.text;
                    final String? lattT = lattC.text;
                    final String? longT = longC.text;

                    if (titleT != null &&
                        type != null &&
                        snippsetT != null &&
                        lattT != null &&
                        longT != null) {
                      if (action == 'create') {
                        await dbMaps.add({
                          "titleT": titleT,
                          "type": type,
                          "snippsetT": snippsetT,
                          "lattT": lattT,
                          "longT": longT
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await dbMaps.doc(documentSnapshot!.id).update({
                          "titleT": titleT,
                          "type": type,
                          "snippsetT": snippsetT,
                          "lattT": lattT,
                          "longT": longT
                        });
                      }

                      // Clear the text fields
                      titleC.text = '';
                      typeC.text = '';
                      snippsetC.text = '';

                      lattC.text = '';
                      longC.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await dbMaps.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Marker'),
          centerTitle: true, // leading: Container(),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _createOrUpdate();
                }),
          ],
        ),
        body: StreamBuilder(
          stream: _fireStore.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data!.docs[index];

                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      leading: const Icon(Icons.store_mall_directory),
                      title:
                          Text('${document['type']} - ${document['titleT']}'),
                      subtitle: Text(
                          '${document['snippset']} | LattLing : ${document['location'].latitude} - ${document['location'].longitude}'),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Press this button to edit a single product
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _createOrUpdate(document)),
                            // This icon button is used to delete a single product
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteProduct(document.id)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
