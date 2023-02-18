import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginScreen;
  const RegisterScreen({Key? key, required this.showLoginScreen}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text controllers
  final _emailController = TextEditingController();
  final _paswordController = TextEditingController();
  final _ConfirmpasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  /// This function cleans up the TextEditingController
  void dispose() {
    _emailController.dispose();
    _paswordController.dispose();
    _ConfirmpasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  /// This function creates a new user, email and password using the user's text input using firebase authentication
  Future signUp() async{
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _paswordController.text.trim()
      );
      User? updateUser = FirebaseAuth.instance.currentUser;
      updateUser!.updateProfile(displayName: _usernameController.text);
    }
  }



  /// This bool checks to see if the confirm password the user typed is the same as the
  /// original password.
  bool passwordConfirmed() {
    if(_paswordController.text.trim() == _ConfirmpasswordController.text.trim()){
      return true;
    } else {
      return false;
    }
  }

  @override
  /// This widget builds the screen containing various of widgets to give a front end visual of a standard register screen
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
                  SizedBox(height: 60,),
                  // Welcome To Bright Planning
                  Text('Sign Up to Start Planning!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),),
                  SizedBox(height: 20),
                  Text('Register Below with your Details!',
                    style: TextStyle(
                        fontSize: 20
                    ),),
                  SizedBox(height: 20),
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
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
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
                  // confirmpassword textfield
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
                          controller: _ConfirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ConfirmPassword',
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
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
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
                      Text('I am a member!',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      GestureDetector(
                        onTap: widget.showLoginScreen,
                        child:
                        Text(' Login Now',style: TextStyle(
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