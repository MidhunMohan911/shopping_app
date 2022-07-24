import 'package:api_sample/screens/all_category.dart';
import 'package:api_sample/screens/cart_screen.dart';
import 'package:api_sample/screens/product_details.dart';
import 'package:api_sample/services/api_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => allCatergory(),
                  ),
                );
              },
              icon: Icon(Icons.view_list)),
              IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),)
        ],
      ),
      body: FutureBuilder(
        future: ApiService().getAllPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                        snapshot.data[index]['title'],
                      ),
                      leading: Image.network(
                        snapshot.data[index]['image'],
                        height: 50,
                        width: 50,
                      ),
                      subtitle: Text('Price -\$' +
                          snapshot.data[index]['price'].toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetails(snapshot.data[index]['id']),
                          ),
                        );
                      });
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
