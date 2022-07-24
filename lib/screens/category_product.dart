import 'package:api_sample/screens/product_details.dart';
import 'package:api_sample/services/api_service.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatelessWidget {
  final String categoryName;
  const CategoryProductScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
          future: ApiService().getProductByCategory(categoryName),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        snapshot.data[index]['image'],
                        height: 50,
                        width: 50,
                      ),
                      title: Text(snapshot.data[index]['title']),
                      subtitle: Text('Price - \$' +
                          snapshot.data[index]['price'].toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(snapshot.data[index]['id']),
                            ));
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
