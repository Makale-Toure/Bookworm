import 'package:bookworm/main.dart';
import 'package:flutter/material.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login')),
        backgroundColor: const Color.fromARGB(255,234, 221, 202),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            FancyButton(
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}