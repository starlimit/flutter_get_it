import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/product_model.dart';
import 'package:flutter_get_it/business_logic/view_models/cart/cart_list_vm.dart';
import 'package:flutter_get_it/business_logic/view_models/product/product_list_vm.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // ProductListVM model;
  // Future<List<ProductModel>> prodList;

  @override
  Widget build(BuildContext context) {
    print('in build');
    final model = Provider.of<ProductListVM>(context, listen: false);

    return SafeArea(
      child: Center(
        child: Consumer<ProductListVM>(
          builder: (context, vm, child) {
            return vm.productList.isEmpty
                ? Container(child: CircularProgressIndicator())
                : makeBody(vm.productList);
          },
        ),

        //Text('Loading....') //makeBody(prodList)
      ),
    );
  }

  Widget makeBody(data) {
    print('in build makeBody');
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data?.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(context, index, data[index]);
        },
      ),
    );
  }

  Widget makeCard(BuildContext context, index, ProductModel item) {
    print('in build makeCard');
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white30),
        child: makeListTile(context, index, item),
      ),
    );
  }

  Widget makeListTile(BuildContext context, index, item) {
    //print('in build makeTile');
    final prodVm = Provider.of<ProductListVM>(context, listen: true);

    //model.productList[index];
    return ListTile(
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
            width: 70.0,
            child: Image.network('${item.image}'),
          )),
      title: Text(
        '${item.title}',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
      ),

      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Price: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(
            '\$${item.price}',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green),
          ),
          RatingBar.builder(
            itemSize: 10,
            initialRating: item.rating,
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
            badgeContent: Text('${item.category}',
                style: TextStyle(color: Colors.white, fontSize: 10)),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: 18,
              color: item.isFavorite ? Colors.pink : Colors.grey,
              icon: item.isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                prodVm.addFavorite(item);
              }),
        ],
      ),
      onTap: () => {_show(context, index, item)},

      // Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
    );
    //  });
  }

  void _show(BuildContext context, int index, ProductModel _item) {
    final cartVm = Provider.of<CartListVM>(context, listen: false);
    final prodVm = Provider.of<ProductListVM>(context, listen: false);
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 8,
        context: context,
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
                                                    Navigator.pop(context);
                                                    //  print('Favourite Pressed ${_item.id}');
                                                    prodVm.addFavorite(_item);
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
                                                    cartVm.addToCart(_item);
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
