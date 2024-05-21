import 'package:flutter/material.dart';
import '../databases/sqlite_database.dart';
import '../models/book_model.dart';
import '../services/barcodescan_service.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({super.key});

  @override
  _AddBooksState createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final SqliteDatabase _dbHelper = SqliteDatabase();
  final BarcodeScanService _barcodeScanService = BarcodeScanService();
  String barcode = '';

  Future<void> scanBarcode() async {
    var result = await _barcodeScanService.scanBarcode();
    if (result != null) {
      setState(() {
        barcode = result;
      });
      // Assume you have a function to get book details from barcode
      String title = "Sample Book Title";
      String author = "Sample Author";
      _dbHelper.insertBook(Book(barcode: barcode, title: title, author: author));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Book')),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Scan result: $barcode\n', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Start barcode scan'),
            ),
          ],
        ),
      ),
    );
  }
}
