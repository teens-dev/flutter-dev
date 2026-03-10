import 'package:flutter/material.dart';
class ContactScreen extends StatelessWidget {
  final String username;
  final String email;
  final int age;
  const ContactScreen({super.key,required this.username,required this.email,required this.age});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Contact ${username}\nemail : ${email}\nage: ${age}"),
    );
  }
}
