import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {

  final String name;

  ContactScreen({this.name = "Guest"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Contact Screen", style: TextStyle(fontSize: 22)),

            SizedBox(height: 20),

            Text("Hello $name"),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Go Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}