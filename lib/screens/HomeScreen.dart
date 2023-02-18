import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timemanagment/screens/StudyTime.dart';
import 'dart:ui';
import 'package:timemanagment/screens/createReminder.dart';
import 'package:timemanagment/screens/reminderScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

@override
class _HomeScreenState extends State<HomeScreen> {
  /// Variable that takes the id of the current user
  final user = FirebaseAuth.instance.currentUser!;


  @override
  /// This Screen creates a home page where the user is met with instruction where they can navigate to other screens to access various of features.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HomePage"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.orangeAccent, Colors.deepOrangeAccent],
            )
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(leading: Icon(Icons.calendar_month), title: Text("Reminders"),
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => reminderScreen(),)
              );
            },),
            ListTile(leading: Icon(Icons.edit), title: Text("Create a Reminder"), onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DeadlineScreen(),)
              );},),
            ListTile(leading: Icon(Icons.schedule), title: Text("Study Time"), onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => StudyTime(),)
              );},),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.orangeAccent,
                ),
                child: Column(
                  children: <Widget>[
                    Text(" To create a Reminder click the Navigation Icon than the Pencil Icon where you can than set up your personal Reminder",style: TextStyle(fontSize: 17,height: 2,color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text(" Than to see your reminder click the Navigation Icon again and than click the Calendar Icon to see your established Reminders.",style: TextStyle(fontSize: 17,height: 2,color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text(" Finally to set a Timer to study click the Navigation Icon and than click the Clock Icon where you can set a timer to your liking",style: TextStyle(fontSize: 17,height: 2,color: Colors.white, fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Signed in as: ' + user.email!,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepOrangeAccent,
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
