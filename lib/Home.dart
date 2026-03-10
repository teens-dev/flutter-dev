import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home ${username}"),
    );
  }
}
