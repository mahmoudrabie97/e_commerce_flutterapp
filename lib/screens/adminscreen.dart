import 'package:e_commerce/admins/mangingproduct.dart';
import 'package:flutter/material.dart';

import '../costants.dart';
import '../admins/adding_product.dart';

class Admin extends StatelessWidget {
  static const routename = 'adminscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmaincolor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddProduct.routename);
                },
                child: Text('ADD product '),
              ),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MangingProduct.routename);
                  },
                  child: Text('Edit Product ')),
              RaisedButton(
                onPressed: () {},
                child: Text(' View Orders '),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
