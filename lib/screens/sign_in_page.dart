import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/screens/home_page.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/custom_flat_icon_button.dart';
import 'package:qr_mobile/widgets/custom_raised_button.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

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
                onPressed: () {
                  context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
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
                      style: TextStyle(
                        fontFamily: 'Kodchasan',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Kayıt Olun',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/signUp');
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
