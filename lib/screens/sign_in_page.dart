import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/screens/home_page.dart';
import 'package:qr_mobile/screens/sign_up_page.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/custom_flat_icon_button.dart';
import 'package:qr_mobile/widgets/custom_raised_button.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

import 'admin_page.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/signIn';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hoşgeldiniz,', style: kWelcomeText),
              Text('Devam etmek için giriş yapınız!', style: kWelcomeHintText),
              SizedBox(height: getProportionateScreenHeight(100.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SignInputArea(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.person),
                    textEditingController: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  SignInputArea(
                    labelText: 'Parola',
                    prefixIcon: Icon(Icons.lock),
                    textEditingController: passwordController,
                    obsecure: true,
                  ),
                  Text(
                    'Şifremi unuttum',
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomRaisedButton(
                text: 'Giriş',
                onPressed: () async {
                  context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  // TODO: Routing'e bak!
                },
              ),
              SizedBox(height: getProportionateScreenHeight(12)),
              CustomFlatIconButton(
                wordThree: 'giriş ',
                wordFour: 'yap',
                onPressed: () async {
                  await context
                      .read<AuthenticationService>()
                      .signInWithGoogle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(120.0)),
              Container(
                width: getProportionateScreenWidth(308.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kayıtlı bir hesabım yok. ',
                      style: kSignHintText,
                    ),
                    InkWell(
                      child: Text(
                        'Kayıt Olun',
                        style: kSignAuthHintText,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(_enterExitRoute(this, SignUpPage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _enterExitRoute(Widget exitPage, Widget enterPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => enterPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        Stack(
      children: [
        SlideTransition(
          position:
              Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
                  .animate(animation),
          child: exitPage,
        ),
        SlideTransition(
          position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
              .animate(animation),
          child: enterPage,
        ),
      ],
    ),
  );
}
