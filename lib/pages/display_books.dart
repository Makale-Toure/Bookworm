import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';
import '../databases/sqlite_database.dart';
import '../models/book_model.dart';

class DisplayBooks extends StatelessWidget {
  final String barcode;
  final String title;
  final String author;
  final String coverUrl;

  const DisplayBooks({
    super.key,
    required this.barcode,
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    final SqliteDatabase dbHelper = SqliteDatabase();


    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Scan succeeded!'),
              SizedBox(width: 10),
              Icon(Icons.insert_emoticon, color: Colors.brown),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 221, 202),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            coverUrl.isNotEmpty ? Image.network(coverUrl) : Container(),
            const SizedBox(height: 20),
            Text('Title: $title', style: const TextStyle(fontSize: 20)),
            Text('Author: $author', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            FancyButton(
              button_icon: Icons.library_add,
              button_text: " Add to Library ",
              button_height: 40,
              button_width: 175,
              button_radius: 50,
              button_color: Colors.brown,
              button_outline_color: Colors.brown,
              button_outline_width: 1,
              button_text_color: Colors.white,
              button_icon_color: Colors.white,
              icon_size: 22,
              button_text_size: 15,
              onClick: () async {
                // On ajoute le livre à la booksDatabase
                await dbHelper.insertBook(Book(barcode: barcode, title: title, author: author));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book added to library'),
                    backgroundColor: Color.fromARGB(255, 121, 85, 72)),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            FancyButton(
              button_icon: Icons.store,
              button_text: " Find a Store ",
              button_height: 40,
              button_width: 175,
              button_radius: 50,
              button_color: Colors.brown,
              button_outline_color: Colors.brown,
              button_outline_width: 1,
              button_text_color: Colors.white,
              button_icon_color: Colors.white,
              icon_size: 22,
              button_text_size: 15,
              onClick: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Searching for stores...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
