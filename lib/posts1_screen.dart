import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:navigation/ProductDetails.dart';
import 'package:navigation/local_storage.dart';
import 'package:navigation/photo_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Posts1Screen(),
    );
  }
}

class Posts1Screen extends StatefulWidget {
  const Posts1Screen({super.key});

  @override
  State<Posts1Screen> createState() => _Posts1ScreenState();
}

class _Posts1ScreenState extends State<Posts1Screen> {

  late Future<List<Product>> futureProducts;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {

    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

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
        backgroundColor: Colors.amber,centerTitle: true,
        title: const Text("Products",style: TextStyle(fontWeight: FontWeight.w800),),
      ),

      body: Column(
        children: [

          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(

              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },

              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(

              future: futureProducts,

              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading data"),
                  );
                }

                if (snapshot.hasData) {

                  // FILTER PRODUCTS
                  final filteredProducts = snapshot.data!
                      .where((product) => product.title
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                      .toList();

                  return ListView.builder(

                    itemCount: filteredProducts.length,

                    itemBuilder: (context, index) {

                      final product = filteredProducts[index];

                      return GestureDetector(

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetails(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),

                          child: ListTile(

                            leading: Image.network(
                              product.thumbnail,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.title),
                            subtitle: Text(
                              "Price: \$${product.price}",
                            ),

                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: Text("No Data"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {

  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.description,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      description: json['description'],
      rating: json['rating'].toDouble(),
    );
  }
}
