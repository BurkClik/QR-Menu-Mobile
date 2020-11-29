import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/routs.dart';
import 'package:qr_mobile/screens/home_page.dart';
import 'package:qr_mobile/screens/sign_in_page.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
      ],
      child: MaterialApp(
        title: 'QR Menu Mobile',
        theme: theme(),
        initialRoute: AuthenticationWrapper.routeName,
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static String routeName = '/checkAuth';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomePage();
    }
    return SignInPage();
  }
}
