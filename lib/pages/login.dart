import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailCtrl.text;
      final password = _passwordCtrl.text;
      final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('${data['message']}');
      } else {
        print('Failed to connect to the server: ${data}');
      }
    }
  }

  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1682687982502-1529b3b33f85?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1752503650851-cbc3f8b00679?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1682687982470-8f1b0e79151a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1752451453007-1bdb81af5b76?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1682686581556-a3f0ee0ed556?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d2638),
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(children: [_cardWidget(), _loginWidget(context)]),
      ),
    );
  }

  Expanded _loginWidget(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 90, right: 70, top: 70),
        alignment: Alignment.center,
        child: ListView(
          children: [
            _title(),
            SizedBox(height: 10),
            _guideTextOne(context),
            SizedBox(height: 40),
            _emailField(),
            SizedBox(height: 15),
            _passwordField(),
            SizedBox(height: 10),
            _guideTextTwo(context),
            SizedBox(height: 25),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Text _title() {
    return Text(
      "Login with an account",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: Color(0xFFf8f7f9),
      ),
    );
  }

  RichText _guideTextOne(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(color: Color(0xFFf8f7f9)),
        children: [
          TextSpan(
            text: ' Sign Up',
            style: TextStyle(color: Colors.tealAccent),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/signup');
              },
          ),
        ],
      ),
    );
  }

  RichText _guideTextTwo(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Forgot your password? ",
        style: TextStyle(color: Color(0xFFf8f7f9)),
        children: [
          TextSpan(
            text: " Reset now",
            style: TextStyle(color: Colors.tealAccent),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/signup');
              },
          ),
        ],
      ),
    );
  }

  Container _loginButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF6e54b5)),
        onPressed: _login,
        child: Text(
          "Log In Account",
          style: TextStyle(color: Color(0xFFf8f7f9), fontSize: 18),
        ),
      ),
    );
  }

  Container _emailField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF3b364c),
      ),
      child: TextFormField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Color(0xFFf8f7f9)),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Email",
          labelStyle: TextStyle(color: Color(0xFF5f5a70)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your email';
          }
          if (!value.contains('@')) {
            return 'Enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Expanded _cardWidget() {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: CarouselSlider(
          options: CarouselOptions(
            height: double.infinity,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
          ),
          items: imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container _passwordField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF3b364c),
      ),
      child: TextFormField(
        controller: _passwordCtrl,
        obscureText: _obscureText,
        style: TextStyle(color: Color(0xFFf8f7f9)),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Color(0xFF5f5a70)),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter your password';
          if (value.length < 6) return 'Password must be at least 6 characters';
          return null;
        },
      ),
    );
  }
}
