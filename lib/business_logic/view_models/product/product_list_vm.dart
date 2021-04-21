import 'package:flutter/foundation.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:flutter_get_it/services/product_service.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:get/get.dart';

class ProductListVM extends ChangeNotifier {
  final IProductService serviceloc = serviceLocator<IProductService>();

  ProductListVM() {
    print('Init in ProductListVM was called');
    fetchProducts();
  }

  List<ProductModel> _productList = [];
  get productList => this._productList;

  List<int> _favoriteList = [];
  get favoriteList => this._favoriteList;

  // List<int> _cartList = [];
  // get cartList => this._cartList;

  void addFavorite(ProductModel item) {
    //print('item=>${_productList.length}');
    //find id in the list and toggle
    //
    _productList.forEach((element) {
      // print('element=>${element.id}');
      if (element.id == item.id) {
        print('before=>${element.isFavorite}');
        element.isFavorite = !element.isFavorite;
        print('after=>${element.isFavorite}');
      }
    });
    //;
    //  _productList[index].isFavorite = !_productList[index].isFavorite;

    notifyListeners();
  }

  Future<List<ProductModel>> fetchProducts() async {
    List<ProductModel> result = [];
    try {
      if (_productList.isEmpty) {
        result = await serviceloc.fetchProducts();
        //print(result.length);
        _productList = result == null ? [] : result;
      } else
        result = _productList;

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
