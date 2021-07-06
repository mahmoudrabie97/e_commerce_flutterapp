import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/loginscreen.dart';
import './screens/sign_up.dart';
import './screens/homepagescreen.dart';
import 'package:provider/provider.dart';
import './providers/loadings.dart';
import './providers/admincontrool.dart';
import './screens/adminscreen.dart';
import './admins/adding_product.dart';
import './admins/mangingproduct.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return Loading();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return Admincontrool();
          },
        ),
      ],
      child: MaterialApp(
        initialRoute: Loginscreen.routename,
        routes: {
          Loginscreen.routename: (context) => Loginscreen(),
          SignUp.routename: (context) => SignUp(),
          HomepageScreen.routename: (context) => HomepageScreen(),
          Admin.routename: (context) => Admin(),
          AddProduct.routename: (context) => AddProduct(),
          MangingProduct.routename: (context) => MangingProduct(),
        },
      ),
    );
  }
}
