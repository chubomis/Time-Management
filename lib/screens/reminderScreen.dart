import 'Events.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dates.dart';


/// Sets the users id from firebase in the variable known as user
final user = FirebaseAuth.instance.currentUser!;

/// This class is the reminder screen holding all the reminders for the users
/// Users can switch out of this screen to the createReminder screen and the StudyTime screen
/// They can also delete reminders in this class
class reminderScreen extends StatefulWidget {

  const reminderScreen({Key? key}) : super(key: key);

  @override
  State<reminderScreen> createState() => _reminderScreenState();
}
final Events _events = Events();

/// This is the extension of the Stateful widget (just shows that the properties can change overtime
/// unlike a Stateless widget
class _reminderScreenState extends State<reminderScreen> {
  List<Object> _reminderList = [];

  @override
  ///This function is called when a widget's dependencies change
  ///Here it is taking the retrieveDatalist function and updating the state of the widget that is calling
  ///retrieveDatalist
  void didChangeDependencies(){
    super.didChangeDependencies();
    retreiveDatalist();
  }
@override
/// This function is finding the index on which container(reminder card) is being tapped.
/// Then it deletes it from the list and the screen
/// Finally it finds the user id of the active user and then finds the document in which their particular data was in
/// to delete it from my database(firebase) so that it show up the next time the user opens the app
  void deleteEvent(Events events, int index) async {
    setState(() {
      print(events.id);
      print(_reminderList.length);
      _reminderList.removeAt(index);
    });
    await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('events').doc(events.id).delete();
  }

  @override
  ///Builds and returns the widgets in the _reminderScreenState class
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Reminders'),
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
      body: SafeArea(
        child: ListView.builder(
          itemCount: _reminderList.length,
            itemBuilder: (context, index) {
            return dates(_reminderList[index] as Events, (context) => deleteEvent(_reminderList[index] as Events, index));

    },
      ),)
    );
  }
  /// This function uses the user id and to check to see if there was data entered in the database
  /// which it then retrieves a list of documents from the event collection in firebase
  Future retreiveDatalist() async{
  final uid = user.uid;
  var data = await FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .collection('events')
      .orderBy('date',descending: true)
      .get();
  setState(() {
    _reminderList = List.from(data.docs.map((doc) => Events.fromSnapshot(doc)));

  });

  }
}
