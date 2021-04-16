import 'package:flutter_get_it/business_logic/view_models/product/product_list_vm.dart';
import 'package:flutter_get_it/services/product_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void serviceLocatorSetUp() {
  serviceLocator.registerLazySingleton<IProductService>(() => ProductService());

  serviceLocator.registerFactory<ProductListVM>(() => ProductListVM());
}
