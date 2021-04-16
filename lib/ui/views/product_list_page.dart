import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/view_models/product/product_list_vm.dart';
import 'package:flutter_get_it/services/service_locator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListVM model = serviceLocator<ProductListVM>();
  @override
  void initState() {
    model.fetchProducts();
    super.initState();
  }

  static int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<ProductListVM>(
        create: (context) => model,
        child: Consumer<ProductListVM>(
          builder: (context, model, child) {
            var scaffold = Scaffold(
              appBar: AppBar(
                title: Text('Title'),
              ),
              body: makeBody(),
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
                    Get.snackbar('Unsupported!', 'Navigation not Implemented',
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM);
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
            return scaffold;
          },
        ),
      ),
    );
  }

  Widget makeListTile(index) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        leading: Container(
            padding: EdgeInsets.only(right: 6.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              // decoration: new BoxDecoration(
              //     border: new Border.all(color: Colors.grey[400])),
              width: 70.0,
              child: Image.network('${model.productList[index].image}'),
            )),
        title: Text(
          '${model.productList[index].title}',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Price: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text(
              '\$${model.productList[index].price}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.green),
            ),
            RatingBar.builder(
              itemSize: 10,
              initialRating: model.productList[index].rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            Badge(
              toAnimate: false,
              padding: EdgeInsets.all(2),
              shape: BadgeShape.square,
              badgeColor: Colors.grey,
              borderRadius: BorderRadius.circular(2),
              badgeContent: Text('${model.productList[index].category}',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ],
        ),

        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      );

  Widget makeBody() => Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: model.productList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(index);
          },
        ),
      );

  Widget makeCard(index) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white30),
          child: makeListTile(index),
        ),
      );
}
