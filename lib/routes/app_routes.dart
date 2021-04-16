part of './app_pages.dart';

abstract class Routes {
  static const NOT_FOUND = '/not_found';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const CART = '/cart';
  static const PRODUCT_LIST = '/product_list';
  static const PRODUCT_DETAILS = '/product_details';
}

abstract class RouteTitles {
  static const NOT_FOUND = 'Page not Found!';
  static const HOME = 'Home';
  static const PROFILE = 'Profile';
  static const CART = 'Cart';
  static const PRODUCT_LIST = 'Product List';
  static const PRODUCT_DETAILS = 'Product Details';
}
