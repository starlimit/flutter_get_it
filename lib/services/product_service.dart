import 'dart:convert';

import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:flutter_get_it/config/config.dart';
import 'package:flutter_get_it/helpers/api_base_helper.dart';

abstract class IProductService {
  Future<List<ProductModel>> fetchProducts();
}

class ProductService implements IProductService {
  final ApiBaseHelper helper = ApiBaseHelper();

  ProductService();

  @override
  Future<List<ProductModel>> fetchProducts() async {
    var queryParameters = {'limits': '20'};
    try {
      final response =
          await helper.get(Config.PRODUCTLIST_GET, queryParameters);

      var listMyModel = List<ProductModel>.from(
          response.map((model) => ProductModel.fromJson(model)));
      return listMyModel;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
