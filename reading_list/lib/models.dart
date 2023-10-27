class TableRowData {
  String? bookId;
  String title;
  String author;
  String part;
  String publishing;
  String memo;

  TableRowData({
    required this.title,
    required this.author,
    required this.part,
    required this.publishing,
    required this.memo,
    this.bookId,
  });
}
