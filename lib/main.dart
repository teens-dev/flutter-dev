import 'package:flutter/material.dart';
import 'package:navigation/About.dart';
import 'package:navigation/Home.dart';
import 'package:navigation/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String username="Lokesh";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:MainScreen(username: username),
    );
  }
}
class MainScreen extends StatefulWidget {
  final String username;
  const MainScreen({super.key,required this.username});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    List pages=[
      HomeScreen(username:widget.username),
      AboutScreen(username:widget.username),
      ContactScreen(username:widget.username),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Screen App"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutScreen(username:widget.username)));
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
            )

          ],
        )
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
          items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
            BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
            BottomNavigationBarItem(icon: Icon(Icons.contact_mail),label: "contact"),
      ]),

    );
  }
}


