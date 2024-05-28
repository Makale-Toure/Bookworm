import 'package:bookworm/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bookworm/databases/sqlite_database.dart';


class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final SqliteDatabase _dbHelper = SqliteDatabase();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String username = _usernameController.text;
      String password = _passwordController.text;

      User newUser = User(username: username, password: password);
      await _dbHelper.insertUser(newUser);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')),
      );

      Navigator.pop(context); // On retourne à la pgae de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Register')),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                )
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                )
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _register,
                child: Text('Register',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}