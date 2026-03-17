import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,title: const Text("cart"),),
      body: Consumer<CartProvider>(builder:(context,cart,child){
        if(cart.cart.isEmpty){
          return const Center(child: Text("cart is empty"));
        }
        return Column(
          children: [
            Expanded(child:ListView.builder(itemCount: cart.cart.length,itemBuilder: (context,index){
             final item = cart.cart[index];
             return ListTile(
               title: Text(item.name),
               subtitle: Text("₹${item.price}"),
               trailing:IconButton(icon: Icon(Icons.delete),onPressed: (){
                 cart.removeFromCart(item);
                 },
               ) ,
             );
        }
        ),
            ),
            Padding(padding: const EdgeInsetsGeometry.all(16),
              child: Text("Total: ₹${cart.totalPrice}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            )
          ],
        );
      }
      ),

    );
  }
}
