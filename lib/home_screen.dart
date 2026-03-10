import 'package:flutter/material.dart';
import 'contact_screen.dart';

class HomeScreen extends StatelessWidget {

  final String username = "Punith";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Home Screen", style: TextStyle(fontSize: 22)),

          SizedBox(height: 20),

          ElevatedButton(
            child: Text("Go to Contact"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(name: username),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}