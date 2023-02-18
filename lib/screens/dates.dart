import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Events.dart';
import 'package:intl/intl.dart';
class dates extends StatelessWidget {
  final Events _events;

  /// This is a constructor of this class which accepts two arguments "_events" and "deleteTapped"
  dates(this._events, this.deleteTapped);
  final Function(BuildContext)? deleteTapped;



  @override
  /// This widget creates the container, more so how it looks and the data it holds and then is called by the reminderScreen to display
  /// it there. It
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                  onPressed: (context){
                    if(deleteTapped != null) deleteTapped!(context);
                  },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
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
                SizedBox(height: 10,),
                Text("Event: ${_events.title}",style: TextStyle(fontSize: 17),),
                SizedBox(height: 10,),
                Text("Time: ${_events.time}",style: TextStyle(fontSize: 17),),
                SizedBox(height: 10,),
                Text("Date: ${DateFormat('MM/dd/yyyy').format(_events.date!).toString()}")
              ],
            ),
      ),
        )
    );
  }
}




