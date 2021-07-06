import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/products.dart';
import '../costants.dart';

class Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  addingproduct(Product product) {
    firestore.collection(kproductcollection).add({
      kproductname: product.pname,
      kproductprice: product.pprice,
      kproductcategory: product.pcategory,
      kproductdescription: product.pdescription,
      kproductlocation: product.plocation,
    });
  }

  Stream<QuerySnapshot> loadproduct() {
    return firestore.collection(kproductcollection).snapshots();
  }
}
