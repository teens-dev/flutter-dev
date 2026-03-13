import 'package:flutter/material.dart';
import 'posts1_screen.dart';

class Productdetails extends StatelessWidget {
  final Product product;
  const Productdetails({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,
        title: Text("PRODUCT DETAILS",style: TextStyle(fontWeight: FontWeight.w800,),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail,width: double.infinity,height: 250,fit: BoxFit.cover,),
            const SizedBox( height: 10,),
            Padding(padding: const EdgeInsets.all(10),
              child: Text(product.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.all(10),
              child: Text("\$${product.price}",style: TextStyle(fontSize: 18,color: Colors.green ,),

            )
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rating: ${product.rating}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.all(10),
              child: Text(product.description,style: const TextStyle(fontSize: 16),),
            )

          ]
        ),
      ),

    );
  }
}
