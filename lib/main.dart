import 'package:flutter/material.dart';
import 'package:navigation/About.dart';
import 'package:navigation/Home.dart';
import 'package:navigation/Listview.dart';
import 'package:navigation/Movies.dart';
import 'package:navigation/MoviesList.dart';
import 'package:navigation/Registrationform.dart';
import 'package:navigation/To-Do.dart';
import 'package:navigation/contact.dart';
import 'package:navigation/Profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String username="Lokesh";
  final String email="gapagarilokesh56@gmail.com";
  final int age=23;
  const MyApp({super.key});
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home:Movieslist()
    );
  }
}
class MainScreen extends StatefulWidget {
  final String username;
  final String email;
  final int age;
  const MainScreen({super.key,required this.username,required this.email,required this.age});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    List pages=[
      HomeScreen(username:widget.username,email: widget.email,age: widget.age),
      AboutScreen(username:widget.username,email: widget.email,age: widget.age),
      ContactScreen(username:widget.username,email: widget.email,age: widget.age),
      ProfileScreen(username:widget.username,email: widget.email,age: widget.age),

    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Screen App"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutScreen(username:widget.username,email: widget.email,age:widget.age,)));
          }, icon: Icon(Icons.info))
        ],
      ),
      drawer: Drawer(
        child:ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text("welcome ${widget.username}",style: TextStyle(color:Colors.white,fontSize: 20),),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                setState(() {
                   currentIndex =0;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcom to the HomeScreen ${widget.username}"),duration: Duration(seconds: 2),));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: (){
                setState(() {
                  currentIndex=1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Contact"),
              onTap: (){
                setState(() {
                  currentIndex=2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: (){
                setState(() {
                  currentIndex=3;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title:Text('Log out'),
              onTap: (){
                setState(() {
                  currentIndex=0;
                });
                Navigator.pop(context);
               // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomeScreen(username: widget.username, email: widget.email, age: widget.age)));
              },
            )

          ],
        )
      ),
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,

          onTap: (index){
          setState(() {
            currentIndex=index;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome to the ${currentIndex+1} ${widget.username}"),duration: Duration(seconds: 2),));

          },
          items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home",),
            BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
            BottomNavigationBarItem(icon: Icon(Icons.contact_mail),label: "contact"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
      ]),

    );
  }
}


