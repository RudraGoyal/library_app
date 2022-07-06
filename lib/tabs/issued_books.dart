import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IssuedBooks extends StatefulWidget {
  const IssuedBooks({Key? key}) : super(key: key);

  @override
  State<IssuedBooks> createState() => _IssuedBooksState();
}

class _IssuedBooksState extends State<IssuedBooks> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool? val = false;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  late List listOfSnapshots;
  var collection = FirebaseFirestore.instance.collection('books');
  @override
  Widget build(BuildContext context) {
    db.settings.persistenceEnabled;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: collection.snapshots(),
          builder: (context, snapshot) {
            listOfSnapshots = snapshot.data!.docs;
            return ListView.builder(
                itemCount: listOfSnapshots.length,
                itemBuilder: (context, index) {
                  if (listOfSnapshots[index]['isIssued'] &&
                      listOfSnapshots[index]['issuedBy'] == userId) {
                    return Card(
                        elevation: 2.0,
                        child: ListTile(
                          title: Text(
                            listOfSnapshots[index]['title'] ?? '',
                          ),
                          subtitle: Text(
                            listOfSnapshots[index]['author'] ?? '',
                          ),
                          trailing: FlatButton(
                            child: Text('Return'),
                            onPressed: () async {
                              print(userId);
                              await collection
                                  .doc(listOfSnapshots[index].data()['bookId'])
                                  .update(
                                {
                                  'isIssued': false,
                                  'issuedBy': '',
                                },
                              );
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('NOTICE'),
                                        content:
                                            Text('Book returned Successfully'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ],
                                      );
                                    });
                              });
                            },
                            color: Colors.amber,
                          ),
                        ));
                  }
                  return Center();
                });
          }),
    );
  }
}
