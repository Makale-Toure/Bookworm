import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  // PAS ENCORE IMPLEMENTER //
  final String title;
  final String author;
  final String coverUrl;
  final List<dynamic> tableOfContents;

  BookDetails({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.tableOfContents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 234, 221, 202),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(coverUrl, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(author, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            SizedBox(height: 16),
            Text('Table of Contents:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: tableOfContents.length,
                itemBuilder: (context, index) {
                  var chapter = tableOfContents[index];
                  return ListTile(
                    title: Text('${chapter['label']}: ${chapter['title']}'),
                    subtitle: Text('Page ${chapter['pagenum']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
