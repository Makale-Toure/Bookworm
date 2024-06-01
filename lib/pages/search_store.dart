import 'package:flutter/material.dart';
import '../services/search_store_service.dart';

class SearchStore extends StatefulWidget {
  const SearchStore({super.key});

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
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Find bookstores'),
              SizedBox(width: 10),
              Icon(Icons.store, color: Colors.brown,),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Find a store here', style: TextStyle(
                fontSize: 24,
                color: Colors.brown.shade800,
                fontWeight: FontWeight.w600)
            ),
          ],
        ),
      ),
    );
  }
}
