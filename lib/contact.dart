import 'package:flutter/material.dart';
class ContactScreen extends StatelessWidget {
  final String username;
  const ContactScreen({super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home ${username}"),
    );
  }
}
