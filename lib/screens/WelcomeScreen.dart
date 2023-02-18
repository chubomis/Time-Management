import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';
import 'dart:async';
import 'package:timemanagment/screens/main_page.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

  class _WelcomeScreenState extends State<WelcomeScreen> {
    @override
    /// Creates an animation that last five seconds and then displays either the login or register page.
    Widget build(BuildContext context) {
      Timer(Duration(seconds: 5), () =>
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()),
          ),);
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(

            child: Image.asset('assets/BlueClock.gif'),
        ),
      );
    }
  }



//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(color: Colors.white),
//           child: FittedBox(
//             child: Icon(
//               Icons.access_alarm,
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }
