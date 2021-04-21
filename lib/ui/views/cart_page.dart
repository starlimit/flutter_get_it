import 'package:flutter/material.dart';
import 'package:flutter_get_it/business_logic/models/cart_model.dart';
import 'package:flutter_get_it/business_logic/view_models/cart/cart_list_vm.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    print('in build cartPage');
    final cartVm = Provider.of<CartListVM>(context, listen: true);

    return cartVm.cartList?.length == 0
        ? Center(
            child: Card(
              elevation: 8,
              child: Text(
                'Ooop! This Cart is Empty',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    child: cartVm.cartList == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: cartVm.cartList.length,
                            itemBuilder: (context, index) {
                              print('in build listtile');
                              final CartModel _item = cartVm.cartList[index];
                              final double sWidth = Get.width;
                              return Card(
                                elevation: 8,
                                child: Dismissible(
                                  onDismissed: (direction) {
                                    cartVm.removeItemFromCart(_item);
                                  },
                                  direction: DismissDirection.horizontal,
                                  background: Container(
                                    color: Colors.red,
                                    child: Align(
                                      alignment: Alignment(-0.9, 0),
                                      child: Icon(Icons.delete_forever,
                                          color: Colors.white),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: Align(
                                      alignment: Alignment(0.9, 0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  child: ListTile(
                                    leading: Container(

                                        // padding: EdgeInsets.all(4),
                                        width: sWidth * 0.20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                color: Colors.red[400],
                                                constraints: BoxConstraints(
                                                    maxWidth: 25),
                                                icon:
                                                    Icon(Icons.delete_forever),
                                                onPressed: () {
                                                  cartVm.removeItemFromCart(
                                                      _item);
                                                }),
                                            Image.network(_item.product.image),
                                          ],
                                        )),
                                    onTap: () {},
                                    title: Align(
                                      widthFactor: 1,
                                      alignment: Alignment.centerLeft,
                                      //  width: sWidth * 0.55,
                                      child: Text(
                                        '${_item.product.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              cartVm.increaseQty(_item);
                                            }),
                                        Text('${_item.quantity}'),
                                        IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              cartVm.decreaseQty(_item);
                                            }),
                                      ],
                                    ),
                                    trailing: Container(
                                        width: sWidth * 0.12,
                                        child: Text(
                                          '\$${(_item.quantity * _item.product.price).toPrecision(1)}',
                                          style: TextStyle(
                                              color: Colors.green.shade800,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.blue.shade100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            //alignment: Alignment.centerLeft,
                            //color: Colors.blue.shade100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Unique Items in Cart :  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      cartVm.cartList?.length.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total Items in Cart :  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      cartVm.totalItems.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Total Cost(\$)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(
                                  cartVm.totalCost.toString(),
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                          Center(
                            //alignment: Alignment.topLeft,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Checkout')),
                          )
                        ],
                      )))
            ],
          );
  }
}
