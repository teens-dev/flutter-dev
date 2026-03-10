import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  final String username;
  const AboutScreen({super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home ${username}"),
    );
  }
}
