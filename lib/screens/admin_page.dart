import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/screens/admin_home.dart';
import 'package:qr_mobile/screens/admin_menu.dart';
import 'package:qr_mobile/screens/admin_orders.dart';
import 'package:qr_mobile/screens/admin_staff.dart';
import 'package:qr_mobile/screens/admin_stock.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/constants.dart';

class Admin extends StatefulWidget {
  static String routeName = '/admin';

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Widget> adminPages = [
    AdminHome(),
    AdminOrders(),
    AdminMenu(),
    AdminStock(),
    AdminStaff()
  ];
  int initialPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cafe 236',
          style: kAppBarCafeText,
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .fetchSignInMethodsForEmail(auth.currentUser.email)
                  .then((value) {
                if (value[0] == "password") {
                  context.read<AuthenticationService>().signOut();
                  Navigator.of(context).pushReplacementNamed("/signIn");
                } else {
                  context.read<AuthenticationService>().googleignOut();
                  Navigator.of(context).pushReplacementNamed("/signIn");
                }
              });
            },
            icon: Icon(Icons.exit_to_app, color: kPrimaryColor),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              buildListTile(context, Icons.home, 'Anasayfa', 0),
              buildListTile(context, Icons.drag_handle, "Siparişler", 1),
              buildListTile(context, Icons.restaurant_menu, "Menü", 2),
              buildListTile(context, Icons.access_alarm, "Stok", 3),
              buildListTile(context, Icons.people, "Çalışanlar", 4),
            ],
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: adminPages[initialPage],
        ),
      ),
    );
  }

  ListTile buildListTile(
      BuildContext context, IconData icon, String tabName, int initalPage) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(tabName, style: kDrawerText),
      onTap: () {
        setState(() {
          initialPage = initalPage;
        });
        Navigator.pop(context);
      },
    );
  }
}
