import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {

  List<Map<String, String>> movies = [
    {
      "name": "Inception",
      "rating": "8.8",
      "description": "A thief steals secrets through dream technology.",
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

  List<Map<String, String>> filtermovies = [];

  @override
  void initState() {
    super.initState();
    filtermovies = movies;
  }

  // Search Function
  void searchmovies(String value) {
    final search = value.toLowerCase();

    setState(() {
      filtermovies = movies.where((movie) {
        final movieName = movie["name"]?.toLowerCase() ?? "";
        final movierating = movie["rating"]?.toLowerCase() ?? "";

        return movieName.contains(search) || movierating.contains(search);
      }).toList();
    });
  }


  // Pull to refresh
  Future<void> refreshmovies() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      filtermovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          "Movies",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),

      body: Column(
        children: [

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: searchmovies,
              decoration: InputDecoration(
                hintText: "Search Movies",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Grid + Pull Refresh
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshmovies,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: filtermovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {

                  final movie = filtermovies[index];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Movie Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.network(
                            movie["image"] ?? "",
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                movie["name"] ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(movie["rating"] ?? ""),
                                ],
                              ),

                              const SizedBox(height: 3),

                              Text(
                                movie["description"] ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
