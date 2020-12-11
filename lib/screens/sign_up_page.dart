import 'package:flutter/material.dart';
import 'package:qr_mobile/screens/home_page.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/custom_flat_icon_button.dart';
import 'package:qr_mobile/widgets/custom_raised_button.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static String routeName = '/signUp';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hesap Oluştur,', style: kWelcomeText),
              Text('Başlamak için kayıt olun!', style: kWelcomeHintText),
              SizedBox(height: getProportionateScreenHeight(100.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SignInputArea(
                    labelText: 'İsim Soyisim',
                    prefixIcon: Icon(Icons.person),
                    textEditingController: nameController,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  SignInputArea(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail),
                    textEditingController: emailController,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  SignInputArea(
                    labelText: 'Parola',
                    prefixIcon: Icon(Icons.lock),
                    textEditingController: passwordController,
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomRaisedButton(
                text: 'Kayıt',
                onPressed: () async {
                  try {
                    await context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } catch (e) {
                    print(e.message);
                  }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(12)),
              CustomFlatIconButton(
                wordThree: 'kayıt ',
                wordFour: 'ol',
                onPressed: () {
                  print('Google');
                },
              ),
              SizedBox(height: getProportionateScreenHeight(120.0)),
              Container(
                width: getProportionateScreenWidth(308.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Zaten bir hesabım var. ',
                      style: TextStyle(
                        fontFamily: 'Kodchasan',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
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
