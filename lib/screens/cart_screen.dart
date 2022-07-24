import 'package:api_sample/screens/product_details.dart';
import 'package:api_sample/services/api_service.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getCart('1'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List products = snapshot.data['products'];
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: ApiService()
                      .getSingleLProduct(products[index]['productId']),
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return ListTile(
                        title: Text(asyncSnapshot.data['title']),
                        leading: Image.network(
                          asyncSnapshot.data['image'],
                          height: 50,
                          width: 50,
                        ),
                        subtitle: Text('Quantity - ' +
                            products[index]['quantity'].toString()),
                        trailing: IconButton(
                            onPressed: () async {
                              await ApiService().deleteCart(1);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('deleted successfully'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(asyncSnapshot.data['id']),
                              ));
                        },
                      );
                    }
                    return const LinearProgressIndicator(
                      minHeight: 1,
                    );
                  },
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Colors.greenAccent,
        child: const Center(
          child: Text(
            'Order Now',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
