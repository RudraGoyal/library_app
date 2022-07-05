import 'package:library_app/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String? bookId;
  DatabaseService({this.bookId});
  final CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('books');

  Future<void> addNewBook(Book newBookModel) async {
    final id = await bookCollection.add({
      'title': newBookModel.title,
      'author': newBookModel.author,
      'bookId': newBookModel.bookId,
      'isIssued': newBookModel.isIssued,
    });
    await bookCollection.doc(id.id).update({'bookId': id.id});
    print('added');
    print(id.id);
  }
}
