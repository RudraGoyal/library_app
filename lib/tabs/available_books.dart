import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvailableBooks extends StatefulWidget {
  const AvailableBooks({Key? key}) : super(key: key);

  @override
  State<AvailableBooks> createState() => _AvailableBooksState();
}

class _AvailableBooksState extends State<AvailableBooks> {
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
                  if (!listOfSnapshots[index]['isIssued']) {
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
                          child: Text('Issue'),
                          onPressed: () async {
                            if (!listOfSnapshots[index]['isIssued']) {
                              print(userId);
                              await collection
                                  .doc(listOfSnapshots[index].data()['bookId'])
                                  .update(
                                {
                                  'isIssued': true,
                                  'issuedBy': userId,
                                },
                              );
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('NOTICE'),
                                        content:
                                            Text('Book issued Successfully'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ],
                                      );
                                    });
                              });
                            }
                          },
                          color: Colors.amber,
                        ),
                        // trailing: Checkbox(
                        //   value: val =
                        //       listOfSnapshots[index].data()['isIssued'],
                        //   onChanged: (value) async {
                        //     print(userId);
                        //     await collection
                        //         .doc(listOfSnapshots[index].data()['bookId'])
                        //         .update(
                        //       {
                        //         'isIssued':
                        //             !listOfSnapshots[index].data()['isIssued'],
                        //         'issuedBy': userId,
                        //       },
                        //     );

                        //     setState(() {
                        //       val = value;
                        //       showDialog(
                        //           context: context,
                        //           builder: (context) {
                        //             return AlertDialog(
                        //               title: const Text('NOTICE'),
                        //               content: Text('Book issued Successfully'),
                        //               actions: [
                        //                 FlatButton(
                        //                     onPressed: () =>
                        //                         Navigator.pop(context),
                        //                     child: const Text('OK'))
                        //               ],
                        //             );
                        //           });
                        //     });
                        //   },
                        // ),
                      ),
                    );
                  }
                  return Center();
                });
          }),
    );
  }
}
