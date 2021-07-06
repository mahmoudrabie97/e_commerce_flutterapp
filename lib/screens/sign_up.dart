import 'package:e_commerce/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../screens/loginscreen.dart';
import '../costants.dart';
import '../screens/homepagescreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../providers/loadings.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  static const routename = 'sign up';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  String email, password, name;
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Customtextfield(
                    onclick: (value) {
                      name = value;
                    },
                    icon: Icons.person,
                    hinttext: 'enter Your Name'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Customtextfield(
                  hinttext: 'Enter your Email',
                  icon: Icons.email,
                  onclick: (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Customtextfield(
                  hinttext: 'Enter your password',
                  icon: Icons.lock,
                  onclick: (value) {
                    password = value;
                  },
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
                          Provider.of<Loading>(context, listen: false)
                              .changeloading(true);
                          if (_globalkey.currentState.validate()) {
                            _globalkey.currentState.save();
                            try {
                              // ignore: unused_local_variable
                              final authresult =
                                  await auth.signup(email, password);
                              Provider.of<Loading>(context, listen: false)
                                  .changeloading(false);
                              Navigator.of(context)
                                  .pushNamed(HomepageScreen.routename);
                            } catch (e) {
                              Provider.of<Loading>(context, listen: false)
                                  .changeloading(false);
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message)));
                            }
                            Provider.of<Loading>(context, listen: false)
                                .changeloading(false);
                          }
                          Provider.of<Loading>(context, listen: false)
                              .changeloading(false);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don you  have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Loginscreen.routename);
                    },
                    child: Text(
                      'Sign in  ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
