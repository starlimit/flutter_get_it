import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/cart_model.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartListVM extends ChangeNotifier {
  List<CartModel> _cartList = [];
  get cartList => this._cartList;

  int _totalItems = 0;
  get totalItems => this._totalItems;

  double _totalCost = 0;
  get totalCost => this._totalCost;

  void addToCart(ProductModel item) {
    if (productExist(item)) {
      //Get.snackbar('Info', 'Product already exist in cart');
      return;
    }
    var uuid = Uuid();
    item.itemInCart = true;
    _cartList.add(new CartModel(id: uuid.v1(), product: item, quantity: 1));
    Get.snackbar('Info', 'Product added to Cart');
    updateTotalItems();
    notifyListeners();
  }

  void increaseQty(CartModel item) {
    _cartList.firstWhere((element) => element.id == item.id).quantity++;
    updateTotalItems();
    notifyListeners();
  }

  void decreaseQty(CartModel item) {
    var qty =
        _cartList.firstWhere((element) => element.id == item.id).quantity--;
    print('==>${qty.toString()}');
    if (qty == 1) removeItemFromCart(item);
    updateTotalItems();
    notifyListeners();
  }

  void removeItemFromCart(CartModel item) {
    _cartList.removeWhere((element) => element.id == item.id);
    updateTotalItems();
    notifyListeners();
  }

  void updateTotalItems() {
    int _qty = 0;
    double _cost = 0;

    _cartList.forEach((element) {
      _qty += element.quantity;
      _cost += element.quantity * element.product.price;
    });
    _totalItems = _qty;
    _totalCost = _cost.toPrecision(1);
  }

  bool productExist(ProductModel item) {
    print(item.id);
    var _exist = _cartList.any((element) => element.product.id == item.id);

    return _exist;
  }
}
