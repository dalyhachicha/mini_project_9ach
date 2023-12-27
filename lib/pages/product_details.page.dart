import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_9ach/models/product.model.dart';
import 'package:mini_project_9ach/utils/constants.dart';
import 'package:mini_project_9ach/widgets/image_swiper.widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorited = false;
  int favoritedCount = 0;
  TextEditingController commentController = TextEditingController();
  List<String> comments = [];

  @override
  void initState() {
    super.initState();
    comments = List<String>.from(widget.product.comments);
  }

  Future<bool> updateFavoris(String productId, bool isIncrement) async {
    try {
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('products');
      DocumentReference productDocument = productsCollection.doc(productId);

      await productDocument.update({
        'favoris':
            isIncrement ? FieldValue.increment(1) : FieldValue.increment(-1),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCommentToProduct(String productId, String comment) async {
    try {
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('products');
      DocumentReference productDocument = productsCollection.doc(productId);

      await productDocument.update({
        'comments': FieldValue.arrayUnion([comment]),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageSwiper(
                imageUrls: widget.product.imageUrls,
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  isFavorited = !isFavorited;
                                  updateFavoris(widget.product.id, isFavorited)
                                      .then((value) {
                                    if (value) {
                                      setState(() {
                                        isFavorited
                                            ? favoritedCount++
                                            : favoritedCount--;
                                      });
                                    }
                                  });
                                },
                              ),
                              Text("${widget.product.favoris + favoritedCount}")
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.product.userAvatar),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Taille: ${widget.product.size}'),
                              Text('${widget.product.price} TND'),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            child: const Text(
                              'Acheter Maintenant',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Ajouter un commenatire...',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (commentController.text.trim().length > 0) {
                                addCommentToProduct(widget.product.id,
                                        commentController.text)
                                    .then((isAdded) {
                                  setState(() {
                                    if (isAdded) {
                                      comments.insert(
                                          0, commentController.text);
                                      commentController.clear();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Probleme d'envoi de commentaire"),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  });
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Commentaires',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      if (comments.isEmpty)
                        const Text("Ecrire le premier comentaire"),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Flexible(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://placekitten.com/50/50"),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Text(comments[index]),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
