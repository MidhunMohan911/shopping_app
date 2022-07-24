import 'package:api_sample/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  int id;
  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleLProduct(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.network(
                      snapshot.data['image'],
                      height: 200,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '\$' + snapshot.data['price'].toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data['title'],
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Chip(
                      label: Text(
                        snapshot.data['category'].toString(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      snapshot.data['description'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ApiService().updateCart(1, id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Product added to cart'),backgroundColor: Color.fromARGB(255, 76, 22, 105),
          ));
        },
        child: const Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
}
