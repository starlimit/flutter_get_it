import 'package:flutter/foundation.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:flutter_get_it/services/product_service.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:get/get.dart';

class ProductListVM extends ChangeNotifier {
  final IProductService serviceloc = serviceLocator<IProductService>();

  ProductListVM() {
    print('Init in ProductListVM was called');
  }

  List<ProductModel> _productList = [];
  get productList => this._productList;

  List<int> _favoriteList = [];
  get favoriteList => this._favoriteList;

  // List<int> _cartList = [];
  // get cartList => this._cartList;

  void addFavorite(int index) {
    //find id in the list and toggle
    _productList[index].isFavorite = !_productList[index].isFavorite;
    print(_productList[index].isFavorite);
    notifyListeners();
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      var result = await serviceloc.fetchProducts();
      //print(result.length);
      _productList = result == null ? [] : result;

      notifyListeners();
      return result;
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
      return null;
    }

    /// return listMyModel;
  }
}
