// import 'package:flutter/material.dart';
//
// class Movie {
//   final String title;
//   final String image;
//
//   Movie(this.title, this.image);
// }
//
// class MovieScreen extends StatefulWidget {
//   @override
//   _MovieScreenState createState() => _MovieScreenState();
// }
//
// class _MovieScreenState extends State<MovieScreen> {
//
//   bool isGrid = false;
//
//   List<Movie> movies = [
//     Movie("The Dark Knight",
//         "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"),
//     Movie("Avengers Endgame",
//         "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg"),
//     Movie("Wonder Woman",
//         "https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
//     Movie("Joker",
//         "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"),
//     Movie("Inception",
//         "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg"),
//     Movie("Interstellar",
//         "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg"),
//     Movie("Titanic",
//         "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"),
//     Movie("Avatar",
//         "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"),
//     Movie("Black Panther",
//         "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"),
//     Movie("Doctor Strange",
//         "https://image.tmdb.org/t/p/w500/xf8PbyQcR5ucXErmZNzdKR0s8ya.jpg"),
//   ];
//
//   List<Movie> filteredMovies = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredMovies = movies;
//   }
//
//   void searchMovies(String query) {
//     final results = movies.where((movie) {
//       return movie.title.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//
//     setState(() {
//       filteredMovies = results;
//     });
//   }
//
//   Future<void> refreshMovies() async {
//     await Future.delayed(Duration(seconds: 1));
//     setState(() {
//       filteredMovies = movies;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Movies"),
//         actions: [
//           IconButton(
//             icon: Icon(isGrid ? Icons.list : Icons.grid_view),
//             onPressed: () {
//               setState(() {
//                 isGrid = !isGrid;
//               });
//             },
//           )
//         ],
//       ),
//
//       body: Column(
//         children: [
//
//
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: TextField(
//               onChanged: searchMovies,
//               decoration: InputDecoration(
//                 hintText: "Search movie...",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: refreshMovies,
//
//               child: isGrid
//                   ? GridView.builder(
//                 itemCount: filteredMovies.length,
//                 gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                 ),
//                 itemBuilder: (context, index) {
//                   return movieCard(filteredMovies[index]);
//                 },
//               )
//                   : ListView.builder(
//                 itemCount: filteredMovies.length,
//                 itemBuilder: (context, index) {
//                   return movieListTile(filteredMovies[index]);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget movieCard(Movie movie) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Expanded(
//             child: Image.network(
//               movie.image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               movie.title,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget movieListTile(Movie movie) {
//     return ListTile(
//       leading: Image.network(movie.image, width: 50, fit: BoxFit.cover),
//       title: Text(movie.title),
//     );
//   }
// }


import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String image;

  Movie(this.title, this.image);
}

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  bool isGrid = false;

  List<Movie> movies = [
    Movie("The Dark Knight",
        "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"),
    Movie("Avengers Endgame",
        "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg"),
    Movie("Wonder Woman",
        "https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
    Movie("Joker",
        "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"),
    Movie("Inception",
        "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg"),
    Movie("Interstellar",
        "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg"),
    Movie("Titanic",
        "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"),
    Movie("Avatar",
        "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"),
    Movie("Black Panther",
        "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"),
    Movie("Doctor Strange",
        "https://image.tmdb.org/t/p/w500/xf8PbyQcR5ucXErmZNzdKR0s8ya.jpg"),
  ];

  List<Movie> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    filteredMovies = movies;
  }

  void searchMovies(String query) {
    final results = movies.where((movie) {
      return movie.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredMovies = results;
    });
  }

  Future<void> refreshMovies() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      filteredMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: searchMovies,
                  decoration: InputDecoration(
                    hintText: "Search movie...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(isGrid ? Icons.list : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    isGrid = !isGrid;
                  });
                },
              )
            ],
          ),
        ),

        Expanded(
          child: RefreshIndicator(
            onRefresh: refreshMovies,

            child: isGrid
                ? GridView.builder(
              itemCount: filteredMovies.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return movieCard(filteredMovies[index]);
              },
            )
                : ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return movieListTile(filteredMovies[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget movieCard(Movie movie) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              movie.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieListTile(Movie movie) {
    return ListTile(
      leading: Image.network(movie.image, width: 50, fit: BoxFit.cover),
      title: Text(movie.title),
    );
  }
}