import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_9ach/models/product.model.dart';
import 'package:mini_project_9ach/widgets/product_card.widget.dart';

class ProductList extends StatefulWidget {
  final String? searchString;
  final List<String> categoriesFilter;

  const ProductList({Key? key, required this.searchString, required this.categoriesFilter}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList =
        fetchProducts(widget.searchString, widget.categoriesFilter);
  }

  Future<List<Product>> fetchProducts(
      String? searchString, List<String>? categories) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    List<Product> productList = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      Product product = Product(
        id: data['id'],
        categories: List<String>.from(data['categories']),
        imageUrls: List<String>.from(data['imageUrls']),
        name: data['name'],
        price: data['price'].toDouble(),
        size: data['size'],
        userAvatar: data['userAvatar'],
        favoris: data['favoris'],
        comments: List<String>.from(data['comments']),
      );

      productList.add(product);
    }

    if (searchString != null && searchString.isNotEmpty) {
      productList = productList
          .where((product) =>
              product.name.toLowerCase().contains(searchString.toLowerCase()))
          .toList();
    }

    if (categories != null && categories.isNotEmpty) {
      productList = productList
          .where((product) => product.categories
              .any((category) => categories.contains(category)))
          .toList();
    }

    return productList;
  }

  Future<void> _refreshProducts() async {
    setState(() {
      productList = fetchProducts(widget.searchString, widget.categoriesFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder(
          future: productList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            } else if (!snapshot.hasData ||
                (snapshot.data as List<Product>).isEmpty) {
              return const Center(
                child: Text('No products available'),
              );
            } else {
              List<Product> products = snapshot.data as List<Product>;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
