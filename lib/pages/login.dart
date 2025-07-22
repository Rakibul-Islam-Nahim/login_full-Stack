import 'package:flutter/material.dart';

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

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailCtrl.text;
      final password = _passwordCtrl.text;

      // Simulate login logic
      print('Email: $email');
      print('Password: $password');
      // Navigate or show success message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00002c),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                _loginTitle(),
                const SizedBox(height: 40),
                _emailField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 30),
                _loginButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to signup page
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(color: Colors.tealAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _loginButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Color(0xFFf22b91),
          minimumSize: Size(100, 10),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.tealAccent),
        ),
      ),
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      controller: _passwordCtrl,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.tealAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
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
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: _emailCtrl,
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

  Text _loginTitle() {
    return const Text(
      'Login',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFf22b91),
      ),
      textAlign: TextAlign.center,
    );
  }
}
