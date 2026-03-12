import 'package:flutter/material.dart';

class Movieslist extends StatefulWidget {
  const Movieslist({super.key});

  @override
  State<Movieslist> createState() => _MovieslistState();
}

class _MovieslistState extends State<Movieslist> {
  List<Map<String,String>> movies = [
    {
      "name": "Inception",
      "rating": "8.8",
      "description": "A thief steals secrets thrLough dream technology.",
      "image": "https://picsum.photos/400/200?1"
    },
    {
      "name": "Interstellar",
      "rating": "8.6",
      "description": "A team travels through space to save humanity.",
      "image": "https://picsum.photos/400/200?2"
    },
    {
      "name": "Avatar",
      "rating": "7.9",
      "description": "A marine explores an alien planet.",
      "image": "https://picsum.photos/400/200?3"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue,centerTitle: true,title: Text("Movies List",style: TextStyle(fontWeight: FontWeight.w800,))),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  child: Image.network(movies[index]["image"]??"",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies[index]["name"]??"",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                      ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,color: Colors.amber,),
                          SizedBox(width: 5),
                          Text(movies[index]["rating"]??""),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(movies[index]["description"]??"",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      ),

                    ],
                  ),
                )
              ],
            )
          );
        }

      ));
  }
}
