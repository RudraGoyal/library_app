import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app/shared/constant.dart';

late String currentBookId;

class EditBook extends StatefulWidget {
  @override
  State<EditBook> createState() => _EditBookState();
  EditBook(String uid) {
    currentBookId = uid;
  }
}

class _EditBookState extends State<EditBook> {
  final GlobalKey _formKey = GlobalKey();
  var collection = FirebaseFirestore.instance.collection('books');

  String? newTitle;
  String? newAuthor;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              'Edit Book',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: customDecoration.copyWith(
                  hintText: 'Title', fillColor: Colors.amber),
              onChanged: (val) {
                newTitle = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: customDecoration.copyWith(
                  hintText: 'Author', fillColor: Colors.amber),
              onChanged: (val) {
                newAuthor = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                Navigator.pop(context);
                await collection
                    .doc(currentBookId)
                    .update({'title': newTitle, 'author': newAuthor});
              },
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.purple[400],
            )
          ],
        ),
      ),
    );
  }
}
