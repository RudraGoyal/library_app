import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:library_app/screens/add_book.dart';
import 'package:library_app/screens/edit_book.dart';
import 'package:library_app/services/database.dart';
import 'package:library_app/services/google_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  AuthService auth = AuthService();

  DatabaseService service = DatabaseService();
  FirebaseFirestore db = FirebaseFirestore.instance;
  var settings;

  var collection = FirebaseFirestore.instance.collection('books');

  var querySnapshot;

  late List listOfSnapshots;

  late Map mapOfData;
  bool? value = false;
  String? issued;

  @override
  Widget build(BuildContext context) {
    db.settings.persistenceEnabled;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        actions: [
          TextButton(
            onPressed: () => auth.signOut(context),
            child: Column(
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
        title: const Text('List of Books'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: collection.snapshots(),
          builder: (ctx, snapshot) {
            //if (listOfSnapshots.isEmpty) print('empty');
            listOfSnapshots = snapshot.data!.docs;
            return ListView.builder(
                itemCount: listOfSnapshots.length,
                itemBuilder: (context, index) {
                  mapOfData = listOfSnapshots[index].data();
                  //  this.value = mapOfData['isIssued'];
                  issued = mapOfData['isIssued'] ? 'Issued' : 'Available';

                  return Card(
                    color: listOfSnapshots[index]['isIssued']
                        ? Colors.red[200]
                        : Colors.green[300],
                    elevation: 2.0,
                    child: ListTile(
                        title: Text(
                          '${mapOfData['title']}  ($issued)',
                        ),
                        subtitle: Text(
                          mapOfData['author'] ?? '',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return EditBook(
                                          listOfSnapshots[index]['bookId']);
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                collection
                                    .doc(listOfSnapshots[index]['bookId'])
                                    .delete();
                              },
                            ),
                          ],
                        )),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddBook();
              });
        }),
        backgroundColor: Colors.amber,
        elevation: 4,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
