import 'package:flutter/material.dart';
import 'package:login_full_stack/pages/login.dart';
import 'package:login_full_stack/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      initialRoute: '/',
      routes: {'/signup': (context) => Signup()},
      home: LoginPage(),
    );
  }
}
