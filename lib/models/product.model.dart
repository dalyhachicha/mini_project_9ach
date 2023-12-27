class Product {
  final String id;
  final List<String> categories;
  final List<String> imageUrls;
  final String name;
  final double price;
  final String size;
  final String userAvatar;
  final int favoris;
  final List<String> comments;

  Product({
    required this.id,
    required this.categories,
    required this.imageUrls,
    required this.name,
    required this.price,
    required this.size,
    required this.userAvatar,
    required this.favoris,
    required this.comments,
  });
}
