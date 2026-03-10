import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final int age;
  const ProfileScreen({super.key,required this.username,required this.email,required this.age});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("profile ${username}\nemail : ${email}\nage: ${age}"),
    );;
  }
}
