import 'product_model.dart';

class CartModel {
  String id;
  ProductModel product;
  int quantity;

  CartModel({this.id, this.product, this.quantity});

  // CartModel.fromJson(Map<String, dynamic> json){
  //     this.id = json['id'];
  //     this.name = json['name'];
  // }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
