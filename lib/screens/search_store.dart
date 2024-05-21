import 'package:flutter/material.dart';
import '../services/search_store_service.dart';

class SearchStore extends StatefulWidget {
  @override
  _SearchStoreState createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
  final SearchStoreService _searchStoreService = SearchStoreService();
  List<String> stores = [];

  Future<void> findBookStores(String isbn) async {
    var results = await _searchStoreService.findBookStores(isbn);
    setState(() {
      stores = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Find Book Stores')),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => findBookStores('9783161484100'), // Example ISBN
              child: Text('Find Stores for Example ISBN'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(stores[index]),
                    onTap: () {
                      // Handle store link click
                    },
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
