import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// This class acts as an event or reminder containing for 4 fields that will be passed to Firebase where the users
/// data will be stored. It holds date which is a DateTime type, time which is a String type, it was originally a TimeStamp type but then
/// later gets converted to a String. Then we have title another String type and id also a String type.
class Events {
  DateTime? date;
  String? time;
  String? title;
  String? id;
Events();

/// Returns a map of the field name along with their exact values
Map<String, dynamic> toJson() => {'date': date, 'title': title, 'time': time};

/// This is a constructor creating an Events object in Firebase and assign the values of the fields
  /// to the value in the snapshot
Events.fromSnapshot(DocumentSnapshot snapshot)
  :title = snapshot['title'],
  time = snapshot['time'],
  date = snapshot['date'].toDate(),
  id = snapshot.id;

}