import 'package:bookworm/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SqliteDatabase {
  static final SqliteDatabase _instance = SqliteDatabase._internal();
  static Database? _booksDatabase;
  static Database? _usersDatabase;

  factory SqliteDatabase() {
    return _instance;
  }

  SqliteDatabase._internal();

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<Database> get booksDatabase async {
    if (_booksDatabase != null) return _booksDatabase!;
    _booksDatabase = await _initBooksDatabase();
    return _booksDatabase!;
  }

  Future<Database> get usersDatabase async {
    if (_usersDatabase != null) return _usersDatabase!;
    _usersDatabase = await _initUsersDatabase();
    return _usersDatabase!;
  }

  Future<Database> _initBooksDatabase() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateBooksDb,
    );
  }

  Future<Database> _initUsersDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateUsersDb,
    );
  }

  Future<void> _onCreateBooksDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE books(id INTEGER PRIMARY KEY AUTOINCREMENT, barcode TEXT, title TEXT, author TEXT, isReading INTEGER)',
    );
  }

  Future<void> _onCreateUsersDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)',
    );
  }

  Future<void> insertBook(Book book) async {
    final db = await booksDatabase;
    await db.insert('books', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertUser(User user) async {
    final db = await usersDatabase;
    String encryptedPassword = encryptPassword(user.password);
    User userWithEncryptedPassword = User(
      id: user.id,
      username: user.username,
      password: encryptedPassword,
    );
    await db.insert('users', userWithEncryptedPassword.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Book>> getBooks() async {
    final db = await booksDatabase;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }
  Future<User?> getUser(String username, String password) async {
    final db = await usersDatabase;
    String encryptedPassword = encryptPassword(password);
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, encryptedPassword],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateBook(Book book) async {
    final db = await booksDatabase;
    await db.update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }
  Future<void> updateUser(User user) async {
    final db = await usersDatabase;
    await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteBook(int id) async {
    final db = await booksDatabase;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> deleteUser(int id) async {
    final db = await usersDatabase;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
