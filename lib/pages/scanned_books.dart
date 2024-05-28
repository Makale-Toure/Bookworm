import 'package:flutter/material.dart';
import '../databases/sqlite_database.dart';
import '../models/book_model.dart';

class ScannedBooks extends StatefulWidget {
  @override
  _ScannedBooksState createState() => _ScannedBooksState();
}

class _ScannedBooksState extends State<ScannedBooks> {
  final SqliteDatabase _dbHelper = SqliteDatabase();

  void markAsReading(int id, bool isReading) async {
    var books = await _dbHelper.getBooks();
    var book = books.firstWhere((book) => book.id == id);
    var updatedBook = Book(
      id: book.id,
      barcode: book.barcode,
      title: book.title,
      author: book.author,
      isReading: isReading,
    );
    await _dbHelper.updateBook(updatedBook);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Scanned books'),
                  SizedBox(width: 10),
                  Icon(Icons.menu_book, color: Colors.brown,),
                ],
              ),
            ),
          backgroundColor: const Color.fromARGB(255, 234, 221, 202),
        ),
        body: FutureBuilder<List<Book>>(
        future: _dbHelper.getBooks(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.brown)
    ));
    }
    if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }
    var books = snapshot.data ?? [];
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        var book = books[index];
        return ListTile(
          title: Text(book.title),
          subtitle: Text(book.author),
          trailing: IconButton(
            icon: Icon(book.isReading ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () => markAsReading(book.id!, !book.isReading),
          ),
        );
      },
    );
    },
        ),
    );
  }
}