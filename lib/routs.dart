import 'package:flutter/widgets.dart';
import 'package:qr_mobile/main.dart';
import 'package:qr_mobile/screens/admin_home.dart';
import 'package:qr_mobile/screens/admin_page.dart';
import 'package:qr_mobile/screens/admin_stock.dart';
import 'package:qr_mobile/screens/home_page.dart';
import 'package:qr_mobile/screens/sign_in_page.dart';
import 'package:qr_mobile/screens/sign_up_page.dart';

final Map<String, WidgetBuilder> routes = {
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
  SignInPage.routeName: (context) => SignInPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  HomePage.routeName: (context) => HomePage(),
  Admin.routeName: (context) => Admin(),
  AdminHome.routeName: (context) => AdminHome(),
  AdminStock.routeName: (context) => AdminStock(),
};
