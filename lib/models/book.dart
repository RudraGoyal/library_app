class Book {
  String bookId;
  String title;
  String author;
  bool isIssued = false;
  late String? issuedBy;
  Book(
      {required this.bookId,
      required this.author,
      required this.isIssued,
      required this.title,
      this.issuedBy});
}
