import 'package:chatapp/components/loginorregister.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Homepage();
          } else
            return LoginOrRegister();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
