import 'package:auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_app/services/database.dart';
import 'package:library_app/services/google_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;

  DatabaseService service = DatabaseService();

  var collection = FirebaseFirestore.instance.collection('books');

  late List listOfSnapshots;

  late Map mapOfData;
  bool? val;

  @override
  Widget build(BuildContext context) {
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
                  print(mapOfData);
                  //  this.value = mapOfData['isIssued'];

                  return Card(
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        mapOfData['title'] ?? '',
                      ),
                      subtitle: Text(
                        mapOfData['author'] ?? '',
                      ),
                      trailing: Checkbox(
                        value: val = listOfSnapshots[index].data()['isIssued'],
                        onChanged: (value) async {
                          print(user!.uid);
                          await collection
                              .doc(listOfSnapshots[index].data()['bookId'])
                              .update(
                            {
                              'isIssued':
                                  !listOfSnapshots[index].data()['isIssued'],
                            },
                          );

                          setState(() {
                            val = value;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('NOTICE'),
                                    content: Text(val!
                                        ? 'Book issued Successfully'
                                        : 'Book returned Scuccessfully'),
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
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
