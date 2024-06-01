import 'package:flutter/material.dart';
import 'package:bookworm/pages/welcome_page.dart';
import 'package:bookworm/pages/add_books.dart';
import 'package:bookworm/pages/library.dart';
import 'package:bookworm/pages/search_store.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BookwormApp());
}

class BookwormApp extends StatelessWidget {
  const BookwormApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromARGB(255,234, 221, 202),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const WelcomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const AddBooks(),
    const Library(),
    const SearchStore(),
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
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner un livre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bibliothèque',
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
