import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/costants.dart';
import 'package:e_commerce/models/products.dart';
import 'package:flutter/material.dart';
import '../services/store.dart';

class MangingProduct extends StatelessWidget {
  static const routename = 'mangingproduct';

  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadproduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Product> _products = [];
                for (var doc in snapshot.data.docs) {
                  _products.add(Product(
                      doc.data()[kproductname],
                      doc.data()[kproductprice],
                      doc.data()[kproductcategory],
                      doc.data()[kproductdescription],
                      doc.data()[kproductlocation]));
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTapUp: (details) async {
                            double dx = details.globalPosition.dx;
                            double dy = details.globalPosition.dy;
                            double dx2 = MediaQuery.of(context).size.width - dx;
                            double dy2 =
                                MediaQuery.of(context).size.height - dy;
                            await showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                MyPopupMenuItem(
                                  onclick: () {
                                    print('Clicked');
                                  },
                                  child: Text('Edit'),
                                ),
                                MyPopupMenuItem(
                                  onclick: () {
                                    print('Delete');
                                  },
                                  child: Text('delete'),
                                )
                              ],
                            );
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    _products[index].plocation,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Opacity(
                                  opacity: .6,
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _products[index].pname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            '\$ ${_products[index].pprice},',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text('loading');
              }
            }));
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onclick;

  MyPopupMenuItem({@required this.child, @required this.onclick});
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onclick();
    Navigator.pop(context);
  }
}
