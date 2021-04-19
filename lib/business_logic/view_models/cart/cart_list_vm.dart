import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/cart_model.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartListVM extends ChangeNotifier {
  List<CartModel> _cartList = [];
  get cartList => this._cartList;

  void addToCart(ProductModel item) {
    if (productExist(item)) {
      //Get.snackbar('Info', 'Product already exist in cart');
      return;
    }
    var uuid = Uuid();
    item.itemInCart = true;
    _cartList.add(new CartModel(id: uuid.v1(), product: item, quantity: 1));
    Get.snackbar('Info', 'Product added to Cart');
    print(_cartList.length);
    notifyListeners();
  }

  void increaseQty(CartModel item) {
    _cartList.firstWhere((element) => element.id == item.id).quantity++;
    notifyListeners();
  }

  void decreaseQty(CartModel item) {
    _cartList.firstWhere((element) => element.id == item.id).quantity--;
    notifyListeners();
  }

  void removeItemFromCart(CartModel item) {
    _cartList.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }

  bool productExist(ProductModel item) {
    print(item.id);
    var _exist = _cartList.any((element) => element.product.id == item.id);

    return _exist;
  }
}
