import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/view_models/cart/cart_list_vm.dart';
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
  CartListVM model2 = serviceLocator<CartListVM>();

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
            return model.productList.length == 0
                ? CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: Text('Title'),
                      actions: [
                        Badge(
                          position: BadgePosition.topEnd(top: 5, end: 5),
                          badgeContent: Text('${model2.cartList?.length}'),
                          child: IconButton(
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () =>
                                  {print('Going to shopping Cart')}),
                        ),
                        // IconButton(
                        //     icon: Icon(Icons.shopping_cart),
                        //     onPressed: () => {})
                      ],
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
                          Get.snackbar(
                              'Unsupported!', 'Navigation not Implemented',
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
            // return scaffold;
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
              onRatingUpdate: null,
            ),
            Badge(
              toAnimate: false,
              padding: EdgeInsets.all(3),
              shape: BadgeShape.square,
              badgeColor: Colors.black54,
              borderRadius: BorderRadius.circular(2),
              badgeContent: Text('${model.productList[index].category}',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                iconSize: 18,
                color: model.productList[index].isFavorite
                    ? Colors.pink
                    : Colors.grey,
                icon: model.productList[index].isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  model.addFavorite(model.productList[index]);
                }),
          ],
        ),
        onTap: () => _show(context, index),

        // Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
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

  void _show(BuildContext ctx, int index) {
    final _item = model.productList[index];
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        isDismissible: true,
        builder: (ctx) => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_item.title}',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5.0),
                          height: Get.height * 0.5,
                          //width: Get.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Image.network('${_item.image}'),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, top: 60),
                                      child: Column(
                                        children: [
                                          Badge(
                                            toAnimate: true,
                                            padding: EdgeInsets.all(5),
                                            shape: BadgeShape.square,
                                            badgeColor: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            badgeContent: Text(
                                                '${_item.category}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '\$ ${_item.price}',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RatingBar.builder(
                                              itemSize: 13,
                                              initialRating: _item.rating,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 2),
                                              itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                              onRatingUpdate: null),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                  color: _item.isFavorite
                                                      ? Colors.pink
                                                      : Colors.grey,
                                                  icon: _item.isFavorite
                                                      ? Icon(Icons.favorite)
                                                      : Icon(Icons
                                                          .favorite_border),
                                                  onPressed: () {
                                                    model.addFavorite(_item);
                                                    print('Favourite Pressed');
                                                  }),
                                              SizedBox(
                                                height: Get.height * 0.2,
                                              ),
                                              IconButton(
                                                  color: _item.itemInCart
                                                      ? Colors.green[900]
                                                      : Colors.grey,
                                                  icon:
                                                      Icon(Icons.shopping_cart),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    model2.addToCart(_item);
                                                  })
                                            ],
                                          )
                                        ],
                                      )))
                            ],
                          )),
                    ],
                  )),
                  Text(
                    '${_item.description}',
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ));
  }
}
