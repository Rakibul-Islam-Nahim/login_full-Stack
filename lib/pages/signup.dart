import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_full_stack/utils/app_color.dart';
import 'package:login_full_stack/widgets/card_widget.dart';

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
  bool _obscureText = true;
  bool isChecked = false;

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

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
      backgroundColor: AppColor.background,
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            CardWidget(),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 90, right: 70, top: 70),
                child: ListView(
                  children: [
                    _signupTitle(),
                    SizedBox(height: 10),
                    _guideTextOne(context),
                    SizedBox(height: 40),
                    _usernameField(),
                    SizedBox(height: 15),
                    _mobileField(),
                    SizedBox(height: 15),
                    _emailField(),
                    SizedBox(height: 15),
                    _passwordField(),
                    SizedBox(height: 10),
                    _checkBoxField(),
                    SizedBox(height: 25),
                    _signupButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _signupTitle() {
    return Text(
      'Create an Account',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: AppColor.text,
      ),
    );
  }

  Row _checkBoxField() {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text("Remember me", style: TextStyle(color: AppColor.text)),
      ],
    );
  }

  Container _usernameField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _nameController,
        style: TextStyle(color: AppColor.text),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Username',
          labelStyle: TextStyle(color: AppColor.hint),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter you Username';
          }
          return null;
        },
      ),
    );
  }

  RichText _guideTextOne(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: TextStyle(color: AppColor.text),
        children: [
          TextSpan(
            text: ' Log In',
            style: TextStyle(color: Colors.tealAccent),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }

  Container _signupButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.button),
        onPressed: _signup,
        child: Text(
          "Sign Up Account",
          style: TextStyle(color: AppColor.text, fontSize: 18),
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
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _passwordController,
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

  Container _emailField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _emailController,
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

  Container _mobileField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.form,
      ),
      child: TextFormField(
        controller: _mobileController,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: AppColor.text),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Mobile Number",
          labelStyle: TextStyle(color: AppColor.hint),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your mobile number';
          }
          return null;
        },
      ),
    );
  }
}
