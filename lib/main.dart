import 'package:flutter/material.dart';
import 'package:bookworm/welcome_page.dart';
import 'package:bookworm/screens/add_books.dart';
import 'package:bookworm/screens/books_in_progress.dart';
import 'package:bookworm/screens/search_store.dart';

void main() {
  runApp(BookwormApp());
}

class BookwormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      home: WelcomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AddBooks(),
    BooksInProgress(),
    SearchStore(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.scanner),
            label: 'Scanner un livre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lectures en cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Trouver des points de vente',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
