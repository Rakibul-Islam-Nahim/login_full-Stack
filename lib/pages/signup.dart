import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final username = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final mobile = int.parse(_mobileController.text);
      final response = await http.post(
        Uri.parse('http://localhost:3000/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "password": password,
          "mobile": mobile,
          "email": email,
        }),
      );
      if (response.statusCode == 201) {
        print('Data created successfully : ${response.body}');
        Navigator.pop(context);
      } else {
        print('Failed to connect');
      }
      // Navigate or show success message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00002c),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign Up Form',
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFFf22b91),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Color(0xFF00002c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(left: 100, right: 100, top: 50),
            child: ListView(
              shrinkWrap: true,
              children: [
                _usernameField(),
                SizedBox(height: 16),
                _emailField(),
                SizedBox(height: 16),
                _passwordField(),
                SizedBox(height: 16),
                _mobileNumber(),
                SizedBox(height: 24),
                _signupButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _signupButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: _signup,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Color(0xFFf22b91),
          minimumSize: Size(100, 10),
        ),
        child: const Text(
          'SignUp',
          style: TextStyle(fontSize: 16, color: Colors.tealAccent),
        ),
      ),
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.tealAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter your password';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.tealAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter your email';
        if (!value.contains('@')) return 'Enter a valid email';
        return null;
      },
    );
  }

  TextFormField _usernameField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        labelText: 'User Name',
        labelStyle: TextStyle(color: Colors.tealAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter your username';
        return null;
      },
    );
  }

  TextFormField _mobileNumber() {
    return TextFormField(
      controller: _mobileController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        labelStyle: TextStyle(color: Colors.tealAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter your mobile number';
        return null;
      },
    );
  }
}
