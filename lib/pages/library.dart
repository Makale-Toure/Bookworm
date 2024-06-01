import 'package:flutter/material.dart';
import '../databases/sqlite_database.dart';
import '../models/book_model.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final SqliteDatabase _dbHelper = SqliteDatabase();
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    var books = await _dbHelper.getBooks();
    setState(() {
      _books = books;
    });
  }

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
    setState(() {
      _fetchBooks();
    });
  }

  Future<void> _deleteBook(int id) async {
    await _dbHelper.deleteBook(id);
    setState(() {
      _fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Library'),
              SizedBox(width: 10),
              Icon(Icons.menu_book, color: Colors.brown),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 221, 202),
      ),
      body: _books.isEmpty
          ? Center(child: Text('No books in the library',
        style: TextStyle(
        fontSize: 24,
        color: Colors.brown.shade800,
        fontWeight: FontWeight.w600)))
          : ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: book.isReading ? Colors.green : Colors.grey),
                  onPressed: () {
                    markAsReading(book.id!, !book.isReading);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteBook(book.id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
