import 'package:flutter/material.dart';
import 'package:mini_project_9ach/models/product.model.dart';
import 'package:mini_project_9ach/pages/product_details.page.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              Image.network(
                widget.product.imageUrls[0],
                fit: BoxFit.cover,
                height: 200.0,
              ),
              Positioned(
                top: 4.0,
                right: 0,
                child: Column(
                  children: [
                    IconButton(
                      iconSize: 28,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                    Text("${widget.product.favoris + (isFavorite ? 1 : 0)}",
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Positioned(
                top: 16.0,
                left: 8.0,
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.product.userAvatar),
                      radius: 16.0,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Taille: ${widget.product.size}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${widget.product.price} TND',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
