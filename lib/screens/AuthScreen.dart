import 'package:flutter/material.dart';
import 'package:timemanagment/screens/LoginScreen.dart';

import 'package:timemanagment/screens/RegisterScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // initially show the login screen
  bool showLoginScreen = true;

  /// This function is called to change the value of the variable
  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  /// If showLoginScreen equals true the login screen is shown if not it will show the register screen
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(showRegisterScreen: toggleScreens);
    } else {
      return RegisterScreen(showLoginScreen:toggleScreens);
    }
  } 
}
