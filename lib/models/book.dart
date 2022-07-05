class Book {
  String bookId;
  String title;
  String author;
  bool isIssued = false;
  Book(
      {required this.bookId,
      required this.author,
      required this.isIssued,
      required this.title});
}
