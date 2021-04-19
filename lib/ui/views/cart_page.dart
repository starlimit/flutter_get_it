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
    final cartVm = Provider.of<CartListVM>(context, listen: true);
    return Container(
      child: cartVm.cartList == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cartVm.cartList.length,
              itemBuilder: (context, index) {
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
                        child: Icon(Icons.delete_forever, color: Colors.white),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment(0.9, 0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    key: UniqueKey(),
                    child: ListTile(
                      leading: Container(

                          // padding: EdgeInsets.all(4),
                          width: sWidth * 0.20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  color: Colors.red[400],
                                  constraints: BoxConstraints(maxWidth: 25),
                                  icon: Icon(Icons.delete_forever),
                                  onPressed: () {
                                    cartVm.removeItemFromCart(_item);
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
                              fontSize: 12, fontWeight: FontWeight.bold),
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
                            '\$${_item.quantity * _item.product.price}',
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
    );
  }
}
