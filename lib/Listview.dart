import 'package:flutter/material.dart';

class Listview extends StatelessWidget {
  final List names=["Lokesh","Balaji","punith"];
  //const Listview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,centerTitle: true,title: Text('LISTVIEW GRID',style: TextStyle(fontWeight: FontWeight.w800,),)),
      body: ListView.builder(itemCount: names.length,itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(names[index]),
        );
      }),
    );
  }
}
