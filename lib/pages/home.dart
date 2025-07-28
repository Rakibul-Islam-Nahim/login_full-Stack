import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_full_stack/utils/app_color.dart';

class User {
  final String username;
  final String email;

  User({required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username'], email: json['email']);
  }
}

class MongoDataPage extends StatefulWidget {
  @override
  _MongoDataPageState createState() => _MongoDataPageState();
}

class _MongoDataPageState extends State<MongoDataPage> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/'),
    ); // Change if deployed

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        users = data.map((json) => User.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text("User List", style: TextStyle(color: AppColor.text)),
        backgroundColor: AppColor.background,
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  elevation: 3,
                  color: AppColor.form,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(color: AppColor.hint),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
