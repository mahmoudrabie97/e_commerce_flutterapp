import 'package:flutter/cupertino.dart';

class Admincontrool extends ChangeNotifier {
  bool isadmin = false;
  changeadminuser(bool value) {
    isadmin = value;
    notifyListeners();
  }
}
