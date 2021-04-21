import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/view_models/cart/cart_list_vm.dart';
import 'package:flutter_get_it/business_logic/view_models/product/product_list_vm.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'business_logic/models/product_model.dart';
import 'routes/routes.dart';

void main() {
  serviceLocatorSetUp();

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<List<ProductModel>>(
          create: (_) => ProductListVM().fetchProducts(),
        ),
        ChangeNotifierProvider<ProductListVM>(create: (_) => ProductListVM()),
        ChangeNotifierProvider<CartListVM>(create: (_) => CartListVM())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.HOME,
        theme: ThemeData(
          primarySwatch: Colors.amberAccent[900],
        ),
        defaultTransition: Transition.leftToRight,
        getPages: AppPages.pages,
      ),
    ),
  );
}
