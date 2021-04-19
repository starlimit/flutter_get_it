class ProductModel {
  int id;
  String title;
  String category;
  String description;
  String image;
  double price;
  double rating;
  bool isFavorite;
  bool itemInCart;

  ProductModel(
      {this.id,
      this.title,
      this.category,
      this.description,
      this.image,
      this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.category = json['category'];
    this.description = json['description'];
    this.image = json['image'];
    this.price = json['price'].toDouble();
    this.rating = (json['id'] % 5).toDouble();
    this.isFavorite = false;
    this.itemInCart = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['rating'] = this.rating;
    return data;
  }
}
