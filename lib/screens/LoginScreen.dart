import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterScreen;
  const LoginScreen({Key? key, required this.showRegisterScreen}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// This textController take the the value of the email input text
  final _emailController = TextEditingController();
  /// This textController take the the value of the password input text
  final _paswordController = TextEditingController();

  /// This function uses Firebase Auth instance allowing the user to sign in
  /// with their email and password
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _paswordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _paswordController.dispose();
    super.dispose();
  }

  @override
  /// Creates a UI that displays two text bocks indicating for the user to put their email and password in.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(
                    Icons.access_alarm,
                    size: 100,
                  ),
              SizedBox(height: 75,),
              // Welcome To Bright Planning
              Text('Welcome To Bright Productivity!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,),),
              SizedBox(height: 20),
              Text('Get Ready To Start Planning!',
              style: TextStyle(
                fontSize: 20
              ),),
              SizedBox(height: 50),
              // Email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _paswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
              //Sign in
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signIn,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
              SizedBox(height: 20),

              // register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',style: TextStyle(
                  fontWeight: FontWeight.bold
               ),),
                  GestureDetector(
                    onTap: widget.showRegisterScreen,
                    child:
                    Text(' Register Now',style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),

            ]),
          ),
        ),
      ),
    );
  }
}
