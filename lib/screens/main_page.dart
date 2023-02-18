import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timemanagment/screens/HomeScreen.dart';
import 'AuthScreen.dart';





class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  /// This widget essentially either sends the user to the home or login/sign up screen depending
  /// if their is data within their user id.
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
