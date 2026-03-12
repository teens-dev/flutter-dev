import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Posts1Screen extends StatefulWidget {
  const Posts1Screen({super.key});

  @override
  State<Posts1Screen> createState() => _Posts1ScreenState();
}

class _Posts1ScreenState extends State<Posts1Screen> {

  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {

    final response =
    await http.get(Uri.parse("https://dummyjson.com/products"),
      headers: {
      "Content-Type": "application/json",
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List products = data["products"];

      return products.map((e) => Product.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),

      body: FutureBuilder<List<Product>>(
        future: futureProducts,

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          if (snapshot.hasData) {

            return ListView.builder(
              itemCount: snapshot.data!.length,

              itemBuilder: (context, index) {

                final product = snapshot.data![index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(

                    leading: Image.network(
                      product.thumbnail,
                      width: 60,
                      fit: BoxFit.cover,
                    ),

                    title: Text(product.title),

                    subtitle: Text("Price: \$${product.price}"),

                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}

class Product {

  final int id;
  final String title;
  final double price;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
