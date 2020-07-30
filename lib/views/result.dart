import 'package:flutter/material.dart';
import 'package:quiz/views/home.dart';
import 'package:quiz/views/quiz.dart';

class Result extends StatefulWidget {
  int score, totalQuestion, correct, incorrect;

  Result({
    this.score,
    this.totalQuestion,
    this.correct,
    this.incorrect,
  });

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String greetings = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var percentage = (widget.score / (widget.totalQuestion * 20)) * 100;
    if (percentage >= 90) {
      greetings = "Outstanding!";
    } else if (percentage >= 80 && percentage < 90) {
      greetings = "Good work!";
    } else if (percentage >= 70 && percentage < 80) {
      greetings = "Good effort!";
    } else {
      greetings = "Need improvement!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              greetings,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You scored ${widget.score} out of ${widget.totalQuestion * 20}",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              "${widget.correct} Correct, ${widget.incorrect} Incorrect",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPlay(),
                ),
              ),
              child: Text(
                "Replay now",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ),
              child: Text(
                "Go back home",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            )
          ],
        ),
      ),
    );
  }
}
