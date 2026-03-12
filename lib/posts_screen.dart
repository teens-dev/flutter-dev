import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> futurePosts;
  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  Future <List<Post>> fetchPosts() async {
    final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
  void retry(){
    setState(() {
      futurePosts=fetchPosts();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,
        title: Text('Posts',style: TextStyle(fontWeight: FontWeight.w800,),
      ),
      ),
      body:FutureBuilder<List<Post>>(future: futurePosts ,builder: (contexrt,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [
             Text("Error: ${snapshot.error}"),

            const SizedBox(height: 10),
            ElevatedButton(onPressed: retry, child: const Text("Retry"))


    ],),);
    }
        else{
          final Posts =snapshot.data!;
          return ListView.builder(itemCount: Posts.length,itemBuilder: (context,index){
            final post=Posts[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
              title:Text(post.title),
              subtitle: Text(post.body),
              ),
    );

    });
    }
    })

    );
  }
}
class Post{
  final int userId;
  final int id;
  final String title;
  final String body;
  Post({required this.userId,required this.id,required this.title,required this.body});
  factory Post.fromJson(Map<String, dynamic> json) {

    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}


