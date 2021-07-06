import 'package:flutter/foundation.dart';

class Loading extends ChangeNotifier {
  bool isloading = false;

  changeloading(bool value) {
    isloading = value;
    notifyListeners();
  }
}
