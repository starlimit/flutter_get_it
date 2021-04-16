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

  Future<void> fetchProducts() async {
    try {
      var result = await serviceloc.fetchProducts();
      _productList = result == null ? [] : result;
      notifyListeners();
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }

    /// return listMyModel;
  }
}
