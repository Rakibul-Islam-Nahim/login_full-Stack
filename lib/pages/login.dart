import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_full_stack/utils/app_color.dart';
import 'package:login_full_stack/widgets/card_widget.dart';

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
        print('Failed to connect to the server: ${data['message']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(children: [CardWidget(), _loginWidget(context)]),
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
        color: AppColor.text,
      ),
    );
  }

  RichText _guideTextOne(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(color: AppColor.text),
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
        style: TextStyle(color: AppColor.text),
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
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.button),
        onPressed: _login,
        child: Text(
          "Log In Account",
          style: TextStyle(color: AppColor.text, fontSize: 18),
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
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: AppColor.text),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Email",
          labelStyle: TextStyle(color: AppColor.hint),
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

  Container _passwordField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _passwordCtrl,
        obscureText: _obscureText,
        style: TextStyle(color: AppColor.text),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: AppColor.hint),
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
