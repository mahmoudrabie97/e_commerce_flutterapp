import 'package:e_commerce/costants.dart';
import 'package:e_commerce/models/products.dart';
import 'package:flutter/material.dart';
import '../widgets/customtextfield.dart';
import '../services/store.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static const routename = 'addproduct';
  String name, price, description, category, imagelocation;
  final _firestore = Store();
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmaincolor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _globalkey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ignore: missing_required_param
                      Customtextfield(
                          hinttext: 'product name',
                          onclick: (value) {
                            name = value;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: missing_required_param
                      Customtextfield(
                          hinttext: 'product price',
                          onclick: (value) {
                            price = value;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: missing_required_param
                      Customtextfield(
                          hinttext: 'product description',
                          onclick: (value) {
                            description = value;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: missing_required_param
                      Customtextfield(
                          hinttext: 'product category',
                          onclick: (value) {
                            category = value;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: missing_required_param
                      Customtextfield(
                          hinttext: ' product location ',
                          onclick: (value) {
                            imagelocation = value;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                          child: Text('Add Product'),
                          onPressed: () {
                            if (_globalkey.currentState.validate()) {
                              _globalkey.currentState.save();
                              _firestore.addingproduct(Product(
                                name,
                                price,
                                category,
                                description,
                                imagelocation,
                              ));
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
