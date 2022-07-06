import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({Key? key}) : super(key: key);

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  bool? val = false;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  late List listOfSnapshots;
  var collection = FirebaseFirestore.instance.collection('books');
  String? issued;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: collection.snapshots(),
          builder: (context, snapshot) {
            listOfSnapshots = snapshot.data!.docs;
            return ListView.builder(
                itemCount: listOfSnapshots.length,
                itemBuilder: (context, index) {
                  issued = listOfSnapshots[index]['isIssued']
                      ? 'Issued'
                      : 'Available';
                  return Card(
                    color: listOfSnapshots[index]['isIssued']
                        ? Colors.red[200]
                        : Colors.green[300],
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        '${listOfSnapshots[index]['title']}  ($issued)',
                      ),
                      subtitle: Text(
                        listOfSnapshots[index]['author'] ?? '',
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
