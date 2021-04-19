import 'package:flutter_get_it/ui/views/product_list_page.dart';
import 'package:flutter_get_it/ui/views/home_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.PRODUCT_LIST, page: () => ProductListPage()),
    GetPage(name: Routes.HOME, page: () => HomePage())
  ];
}
