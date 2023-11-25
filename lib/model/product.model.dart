class Product {
  String title;
  List<String> categories;
  List<String> colors;
  String description;
  String id;
  String previewUrl;
  int price;

  Product({
    required this.title,
    required this.categories,
    required this.colors,
    required this.description,
    required this.id,
    required this.previewUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      categories: json['categories'].cast<String>(),
      colors: json['colors'].cast<String>(),
      description: json['description'],
      id: json['id'],
      previewUrl: json['previewUrl'],
      price: json['price'],
    );
  }
}