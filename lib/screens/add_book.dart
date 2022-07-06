import 'package:flutter/material.dart';
import 'package:library_app/services/database.dart';
import 'package:library_app/shared/constant.dart';
import '../models/book.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final GlobalKey _formkey = GlobalKey();
  DatabaseService dbService = DatabaseService();

  late String title;
  late String author;
  late String bookId;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              'Add New Book',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: customDecoration.copyWith(
                  hintText: 'Title', fillColor: Colors.amber),
              onChanged: (val) => title = val,
              validator: (value) =>
                  value == null || value == '' ? 'Enter valid password' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: customDecoration.copyWith(
                  hintText: 'Author', fillColor: Colors.amber),
              onChanged: (val) => author = val,
              validator: (value) =>
                  value == null || value == '' ? 'Enter valid password' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Book newBook = Book(
                    title: title,
                    author: author,
                    bookId: 'default',
                    isIssued: false,
                    issuedBy: '');

                dbService.addNewBook(newBook);

                Navigator.pop(context);
              },
              color: Colors.purple[400],
              child: const Text(
                'Add Book',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
