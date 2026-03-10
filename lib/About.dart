import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  final String username;
  final String email;
  final int age;
  const AboutScreen({super.key,required this.username,required this.email,required this.age});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("About ${username}\nemail : ${email}\nage: ${age}"),
    );
  }
}
