import 'package:flutter/material.dart';
import '../costants.dart';

class Customtextfield extends StatelessWidget {
  final IconData icon;
  final String hinttext;
  final Function onclick;
  Customtextfield(
      {@required this.icon, @required this.hinttext, @required this.onclick});

  // ignore: missing_return
  String errormessage(String str) {
    switch (str) {
      case 'enter Your Name':
        return 'name is  empty';
      case 'Enter your password':
        return 'password is empty';
      case 'Enter your Email':
        return 'email is empty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return errormessage(hinttext);
        }
      },
      onSaved: onclick,
      obscureText: hinttext == 'Enter your password' ? true : false,
      decoration: InputDecoration(
        hintText: hinttext,
        prefixIcon: Icon(
          icon,
          color: kmaincolor,
        ),
        filled: true,
        fillColor: ksecondarycolor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
