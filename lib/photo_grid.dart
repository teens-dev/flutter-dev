import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class PhotoGridScreen extends StatefulWidget {
  const PhotoGridScreen({super.key});

  @override
  State<PhotoGridScreen> createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {

  late Future<List<Photo>> futurePhotos;

  Future<List<Photo>> fetchPhotos() async {

    final response = await http.get(
      Uri.parse("https://picsum.photos/v2/list?page=1&limit=100"),
    );

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((e) => Photo.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load photos");
    }
  }

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery"),
      ),

      body: FutureBuilder<List<Photo>>(

        future: futurePhotos,

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmer();
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Photos Found"));
          }

          final photos = snapshot.data!;

          return GridView.builder(

            padding: const EdgeInsets.all(10),

            itemCount: photos.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,

            ),

            itemBuilder: (context, index) {

              final photo = photos[index];

              return GestureDetector(

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhotoDetailScreen(photo: photo),
                    ),
                  );

                },

                child: Hero(

                  tag: photo.id,

                  child: CachedNetworkImage(

                    imageUrl: photo.downloadUrl,

                    fit: BoxFit.cover,

                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),

                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),

                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildShimmer() {

    return GridView.builder(

      itemCount: 6,

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),

      itemBuilder: (_, __) {

        return Shimmer.fromColors(

          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,

          child: Container(

            margin: const EdgeInsets.all(8),

            color: Colors.white,

          ),
        );
      },
    );
  }
}

class Photo {

  final String id;
  final String downloadUrl;
  final String author;

  Photo({

    required this.id,
    required this.downloadUrl,
    required this.author,

  });

  factory Photo.fromJson(Map<String, dynamic> json) {

    return Photo(

      id: json['id'].toString(), // FIXED INT TO STRING
      downloadUrl: json['download_url'],
      author: json['author'],

    );
  }
}

class PhotoDetailScreen extends StatelessWidget {

  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(photo.author),
      ),

      body: Center(

        child: Hero(

          tag: photo.id,

          child: CachedNetworkImage(

            imageUrl: photo.downloadUrl,

            placeholder: (context, url) =>
            const CircularProgressIndicator(),

            errorWidget: (context, url, error) =>
            const Icon(Icons.error),

          ),
        ),
      ),
    );
  }
}
