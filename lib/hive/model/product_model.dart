class ProductModel {
  List<Product> productsList = [];

  // if List<Product>? nullable, the proudctsList should be 
  // declared in ProductModel.fromJson() method as empty list,
  // otherwise there will be error with adding data to null list
  // Example:
  //
  // ProductModel.fromJson(...) {
  //   productList = [];
  //   for (var product in ...) {
  //     productList.add(); 
  //   }
  // }
  //

  ProductModel.fromJson(Map<String, dynamic> json) {
    for (var product in json["products"]) {
      productsList.add(Product.fromJson(product));
  }
  }
  
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final List<dynamic> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.images,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      images: json['images'],
      thumbnail: json['thumbnail'],
    );
  }
}
