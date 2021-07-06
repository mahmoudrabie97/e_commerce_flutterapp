import 'dart:ui';
import 'package:provider/provider.dart';
import '../screens/homepagescreen.dart';
import 'package:flutter/material.dart';
import '../costants.dart';
import '../widgets/customtextfield.dart';
import './sign_up.dart';
import '../services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../providers/loadings.dart';
import '../providers/admincontrool.dart';
import '../screens/adminscreen.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
  static const routename = 'loginscreen ';
  String email;
  String password;
  final admminpassword = 'Admin1234';

  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isAdmin = Provider.of<Admincontrool>(context).isadmin;
    Auth auth = Auth();
    return Scaffold(
      backgroundColor: kmaincolor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Loading>(context).isloading,
        child: Form(
          key: _globalkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'icons/buy.png',
                        //width: MediaQuery.of(context).size.width * .4,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'buy it',
                          style:
                              TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Customtextfield(
                  onclick: (value) {
                    email = value;
                  },
                  hinttext: 'Enter your Email',
                  icon: Icons.email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Customtextfield(
                  onclick: (value) {
                    password = value;
                  },
                  hinttext: 'Enter your password',
                  icon: Icons.lock,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 60, left: 60),
                child: Builder(
                  builder: (BuildContext context) {
                    return FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        await validating(context, auth);
                      },
                      child: Text(
                        'log in ',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don not  have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUp.routename);
                    },
                    child: Text(
                      'Sign Up  ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<Admincontrool>(context, listen: false)
                          .changeadminuser(true);
                    },
                    child: Text(
                      ' i am admin ',
                      style:
                          TextStyle(color: isAdmin ? kmaincolor : Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<Admincontrool>(context, listen: false)
                          .changeadminuser(false);
                    },
                    child: Text(
                      'i am user',
                      style:
                          TextStyle(color: isAdmin ? Colors.white : kmaincolor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future validating(BuildContext context, Auth auth) async {
    Provider.of<Loading>(context, listen: false).changeloading(true);
    if (_globalkey.currentState.validate()) {
      _globalkey.currentState.save();
      if (password == admminpassword) {
        try {
          await auth.signin(email, password);
          Navigator.of(context).pushNamed(Admin.routename);
        } catch (e) {
          Provider.of<Loading>(context, listen: false).changeloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      } else {
        try {
          // ignore: unused_local_variable
          final authresult = await auth.signin(email, password);
          Provider.of<Loading>(context, listen: false).changeloading(false);
          Navigator.of(context).pushNamed(HomepageScreen.routename);
          Provider.of<Loading>(context, listen: false).changeloading(false);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
        Provider.of<Loading>(context, listen: false).changeloading(false);
      }
      Provider.of<Loading>(context, listen: false).changeloading(false);
    }
    Provider.of<Loading>(context, listen: false).changeloading(false);
  }
}
