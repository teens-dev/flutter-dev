import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  final String username;
  final String email;
  final int age;
  const HomeScreen({super.key,required this.username,required this.email,required this.age});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home ${username}\nemail : ${email}\nage: ${age}"),


    );
  }
}
