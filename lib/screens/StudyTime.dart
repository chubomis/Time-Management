import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyTime extends StatefulWidget {
  const StudyTime({Key? key}) : super(key: key);

  @override
  State<StudyTime> createState() => _StudyTimeState();
}

class _StudyTimeState extends State<StudyTime> {

  /// Variable, this variable is an int type. It is the placeholder for whatever
  /// int the user inputs.
  int seconds = 0;

  /// This variable is a Timer type. Essentially it is the countdown timer itself
  /// which I can manipulate in various of ways such as increasing or decreasing the timer.
  late Timer timer;

  /// This variable is for the text field that the user can input any number in
  final secondsController = TextEditingController();

  /// This variable is calling the ConfettiController which is used to manipulate the confetti animation
  final _controller =ConfettiController();
  bool isPlaying = false;
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  /// This function parses the input that the user input to ensure that it can only be an int.
  /// Then it sets the timer to go down 1 int every 1 seconds which it will then stop the timer when it reaches 0 and
  /// play a confetti animation
  void startTimer() {
    setState(() {
      seconds = int.parse(secondsController.text);
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
        }
        if(seconds == 1){
          _controller.play();
        }else{
          _controller.stop();
        }
      });
    });
  }
  @override
  /// Displays button to start which on press will start the timer, displays the timer itself and an appbar
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Study Time!"),
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
        body:
            SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                  child: Center(child: Text("$seconds",style: TextStyle(fontSize: 100))),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height*0.3,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width*0.6,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.orangeAccent,
                  ),
                ),
              ConfettiWidget(confettiController: _controller),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: startTimer,
                child: Text('Start Timer'),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: secondsController, textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter seconds",
                  ),
                ),
              ),
            ],
          ),
        )

            )
    );
  }
}






