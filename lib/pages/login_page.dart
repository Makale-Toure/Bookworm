import 'package:bookworm/main.dart';
import 'package:bookworm/models/user_model.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bookworm/databases/sqlite_database.dart';
import 'package:bookworm/pages/connexion_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SqliteDatabase _dbHelper = SqliteDatabase();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String username = _usernameController.text;
      String password = _passwordController.text;

      User? user = await _dbHelper.getUser(username, password);

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful'),
            backgroundColor: Color.fromARGB(255, 121, 85, 72),),
        );
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password'),
            backgroundColor: Color.fromARGB(255, 121, 85, 72),),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login')),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                )
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                )
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
              )
                  : FancyButton(
                  button_icon: Icons.login,
                  button_text: "  Login  ",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.brown,
                  button_outline_color: Colors.brown,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    _login();
                  }),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConnexionPage()),
                  );
                },
                child: const Text('Don\'t have an account? Register',
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


