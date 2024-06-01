import 'package:bookworm/pages/display_books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book_model.dart';
import '../services/barcodescan_service.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({super.key});

  @override
  _AddBooksState createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  bool isScanSuccess = false;
  final BarcodeScanService _barcodeScanService = BarcodeScanService();
  String barcode = '';
  String title = '';
  String author = '';
  String coverUrl = '';

  Future<void> scanBarcode() async {
    var result = await _barcodeScanService.scanBarcode();
    if (result != null) {
      setState(() {
        barcode = result;
        fetchBookDetails();
      });
    }
  }

  Future<void> fetchBookDetails() async {
    final url = 'https://openlibrary.org/api/books?bibkeys=ISBN%3A$barcode&jscmd=details&format=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final bookData = data['ISBN:$barcode'];

      if (bookData != null && bookData['details'] != null) {
        setState(() {
          title = bookData['details']['title'] ?? 'No title found';
          author = bookData['details']['authors'] != null && bookData['details']['authors'].isNotEmpty
              ? bookData['details']['authors'][0]['name']
              : 'No author found';
          coverUrl = 'http://covers.openlibrary.org/b/isbn/$barcode-M.jpg';
          isScanSuccess = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayBooks(
                barcode: barcode,
                title: title,
                author: author,
                coverUrl: coverUrl,
              ),
            ),
          );
        });
      }
    } else {
      setState(() {
        isScanSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add Book'),
              SizedBox(width: 10),
              Icon(Icons.bookmark_add, color: Colors.brown,),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 221, 202),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text('Scan result: $barcode\n', style: TextStyle(fontSize: 20)),
            GestureDetector(
              onTap: () {
                scanBarcode();
              },
              child: Icon(
                Icons.qr_code_scanner_sharp,
                size: 300.0,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tap to Scan',
              style: TextStyle(
                fontSize: 24,
                color: Colors.brown.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
