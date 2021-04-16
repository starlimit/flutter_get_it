import 'package:flutter/material.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:get/get.dart';

import 'routes/routes.dart';

void main() {
  serviceLocatorSetUp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.PRODUCT_LIST,
    theme: ThemeData(
      primarySwatch: Colors.amberAccent[900],
    ),
    defaultTransition: Transition.leftToRight,
    getPages: AppPages.pages,
  ));
}
