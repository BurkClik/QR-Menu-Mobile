import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/services/authentication_service.dart';

class Admin extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        centerTitle: true,
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
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Selam'),
        ),
      ),
    );
  }
}
