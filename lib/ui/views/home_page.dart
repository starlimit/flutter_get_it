import 'package:badges/badges.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:flutter_get_it/business_logic/view_models/cart/cart_list_vm.dart';
import 'package:flutter_get_it/business_logic/view_models/product/product_list_vm.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:flutter_get_it/ui/views/cart_page.dart';
import 'package:flutter_get_it/ui/views/products_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CartListVM model = serviceLocator<CartListVM>();

  int selectedIndex = 0;

  final List<Widget> _children = [
    ProductPage(),
    CartPage(),
    Text('Page-2'),
    Text('Page-4'),
  ];

  @override
  void initState() {
    // model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Store'), actions: [
        // Consumer<CartListVM>(
        //   builder: (context, CartListVM model, child) {
        //     return Text('${model.cartList?.length}');
        //   },
        // ),
        // Consumer<CartListVM>(builder: (context, model, child) {
        //   return Text('${Provider.of<CartListVM>(context).cartList?.length}');
        // }),
        Consumer<CartListVM>(
          builder: (context, CartListVM model, child) {
            return Badge(
              position: BadgePosition.topEnd(top: 5, end: 5),
              badgeContent: // Text('${model.cartList?.length}'),
                  Consumer<CartListVM>(
                      builder: (context, CartListVM model, child) {
                return Text('${model.cartList?.length}');
              }),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  }),
            );
          },
        ),
        // Badge(
        //   position: BadgePosition.topEnd(top: 5, end: 5),
        //   badgeContent: // Text('${model.cartList?.length}'),
        //       Consumer<CartListVM>(builder: (context, CartListVM model, child) {
        //     return Text('${model.cartList?.length}');
        //   }),
        //   child: IconButton(
        //       icon: Icon(Icons.shopping_cart),
        //       onPressed: () {
        //         setState(() {
        //           selectedIndex = 1;
        //         });
        //       }),
        // ),
        // ),
      ]),
      body:
          // Consumer<CartListVM>(
          //   builder: (context, model, child) => Column(
          //     children: [
          //       Container(
          //         color: Colors.grey,
          //         padding: EdgeInsets.all(50),
          //         height: 200,
          //         child: Text('${model.cartList?.length}'),
          //       ),
          //       Center(child: Text('3')),
          //       ElevatedButton(
          //         onPressed: () => {
          //           model.addToCart(new ProductModel(
          //               id: model.cartList == null ? 0 : model.cartList.length,
          //               title: 'title',
          //               category: 'shkgsjk',
          //               image: 'sjkglsgs',
          //               price: 34.0))
          //         },
          //         child: Text('Add new Item'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () => {Get.to(ProductPage())},
          //         child: Text('Go to Product Page'),
          //       ),
          //     ],
          //   ),
          // ),
          _children[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.green,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          showSelectedItemShadow: false,
          barHeight: 70,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.list,
            label: 'Products',
          ),
          FFNavigationBarItem(
            iconData: Icons.shopping_basket,
            label: 'Cart',
            selectedBackgroundColor: Colors.orange,
          ),
          FFNavigationBarItem(
            iconData: Icons.account_balance,
            label: 'Orders',
            selectedBackgroundColor: Colors.purple,
          ),
          FFNavigationBarItem(
            iconData: Icons.account_box,
            label: 'Profile',
            selectedBackgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
