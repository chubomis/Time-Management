import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Events.dart';

/// This variable is a FirebaseAuth type which initializes the FirebaseAuth object
/// allowing the rest of the app to work with Firebase's Auth services
FirebaseAuth auth = FirebaseAuth.instance;

/// This variable retrieves the current user's id which we can use to
/// know where to manipulate their data.
final user = FirebaseAuth.instance.currentUser!;


class DeadlineScreen extends StatefulWidget {
  const DeadlineScreen({Key? key}) : super(key: key);

  @override
  State<DeadlineScreen> createState() => _DeadlineScreenState();
}



class _DeadlineScreenState extends State<DeadlineScreen> {


  /// Creates an instance of the Events class which uses the _events variable which can
  /// be used to access properties on the object or to call functions
  final Events _events = Events();

  /// TextEditingController type variable that checks the users input in the text field
  TextEditingController userIntput = TextEditingController();

  /// bool type variable to check if a text field is empty
  bool _isTextFieldEmpty = true;



  InputDecoration reminderTitle = InputDecoration(
      hintText: 'Enter the Title of your Reminder'
  );

  /// TimeOfDay type variable which is used to set a placeholder for what the user want to input for
  /// the time
  TimeOfDay _timeOfDay = TimeOfDay(hour: 00, minute: 00);

  /// This function display the time picker package which allow the user to meet with a
  /// nice friendly ui where the can pick the time and update the _timeOfDay variable.
  void displayTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }




  /// Placeholder variable type DateTime which the user can later manipulate
  /// to changed to their preferred date.
  DateTime idleDate =
  DateTime.now();

  /// This function display a ui from the datetimepicker package allowing the user to
  /// choose a date which will update the idleDate variable.
  void displayDate(BuildContext context) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2060)
    ).then((value) {
      setState(() {
        idleDate = value!;
      });
    });
  }


  /// User type variable getting the current user's id
  final User? userId = auth.currentUser;


  /// This function takes the data the user inputed, converting it to the proper data types
  /// the firebase firestore fields take. Than it will get uploaded to the Firebase collection
  /// into the fields
  void loadData() async{

    _events.date = idleDate;
    _events.time =  _timeOfDay.format(context).toString();
    _events.title = userIntput.text;


    await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('events')
        .add(_events.toJson());



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Your Reminders!"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[

            SizedBox(height: 50),
            Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: (){},
                      child: Container(

                        height: 100,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.orangeAccent,
                        ),
                        child: Column(

                          children: <Widget>[
                            SizedBox(height: 20,),
                            SizedBox(
                              width: 320,

                              child: TextField(

                                decoration:  reminderTitle,textAlign: TextAlign.center,
                                controller: userIntput,
                                onChanged: (text){
                                  setState(() {
                                    _isTextFieldEmpty =text.trim().isEmpty;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ]
            ),

          SizedBox(height: 30),

            Column(
              children: <Widget>[
         GestureDetector(
          onTap: (){
            displayTime(context);
          },
        child: Container(
            height: 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.orangeAccent,
            ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Text("Click to Enter the Time of The Reminder",style: TextStyle(fontSize: 17),),
              SizedBox(height: 10,),
              Text(_timeOfDay.format(context).toString(), style: TextStyle(fontSize: 17),),
            ],
          ),
        )
        ),
      ]
    ),

          SizedBox(height: 30),
            Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: (){
                        displayDate(context);
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.orangeAccent,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Text("Click to Enter the Date of The Reminder",style: TextStyle(fontSize: 17),),
                            SizedBox(height: 10,),
                            Text(idleDate.year.toString()+'-'+idleDate.month.toString()+'-'+idleDate.day.toString(), style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      )
                  ),
                ]
            ),
            SizedBox(height: 30),
              Column(
            children: <Widget>[
              ElevatedButton(

                  onPressed: (){
                    _isTextFieldEmpty ? null :
                    loadData();
                  },

                style: ElevatedButton.styleFrom(
                primary:Colors.orangeAccent
              ),

                  child: Text("Confirm Reminder"),
              ),

        ],
          ),
      ],
        )

      ),
    );

  }
}

