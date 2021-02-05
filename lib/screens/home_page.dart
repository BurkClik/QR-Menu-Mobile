import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/screens/history.dart';
import 'package:qr_mobile/screens/home_body.dart';
import 'package:qr_mobile/screens/profile.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/waiterHome';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _currentScreen = 1;
  final List<Widget> screenList = [History(), HomeBody(), Profile()];
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _showMyDialog() async {
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kullanıcı Bilgileri'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SignInputArea(
                  prefixIcon: Icon(Icons.people),
                  hintText: auth.currentUser.displayName,
                  textEditingController: nameController,
                ),
                SizedBox(height: 10),
                SignInputArea(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Yeni Şifre',
                  obsecure: true,
                  textEditingController: passwordController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Onayla'),
              onPressed: () async {
                try {
                  if (nameController.text.trim() !=
                      auth.currentUser.displayName) {
                    await auth.currentUser
                        .updateProfile(displayName: nameController.text.trim());
                  }
                  await auth.currentUser
                      .updatePassword(passwordController.text.trim());
                } catch (e) {
                  print(e.message);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cafe 236',
          style: kAppBarCafeText,
        ),
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
            icon: Icon(Icons.exit_to_app, color: kSecondColor),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            _showMyDialog();
          },
          icon: Icon(
            Icons.settings,
            color: kSecondColor,
          ),
        ),
      ),
      /*  bottomNavigationBar: ConvexAppBar(
        backgroundColor: kSecondColor,
        items: [
          TabItem(icon: Icons.history, title: 'Geçmiş'),
          TabItem(icon: Icons.home_outlined, title: 'Anasayfa'),
          TabItem(icon: Icons.person_outline, title: 'Profil'),
        ],
        initialActiveIndex: 1,
        onTap: (int index) {
          setState(() {
            _currentScreen = index;
          });
        },
      ), */
      body: screenList[_currentScreen],
    );
  }
}
