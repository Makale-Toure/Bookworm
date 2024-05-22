class Book {
  final int? id;
  final String barcode;
  final String title;
  final String author;
  final bool isReading;


  Book({this.id, required this.barcode, required this.title, required this.author, this.isReading = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'title': title,
      'author': author,
      'isReading': isReading ? 1 : 0,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      barcode: map['barcode'],
      title: map['title'],
      author: map['author'],
      isReading: map['isReading'] == 1,
    );
  }
}
