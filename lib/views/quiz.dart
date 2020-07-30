import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz/data/data.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/views/result.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  List<QuestionModel> _questions = new List<QuestionModel>();
  int index = 0, correct = 0, incorrect = 0, points = 0;

  double beginAnim = 0.0, endAnim = 1.0;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questions = getQuestions();

    animationController =
        AnimationController(duration: const Duration(seconds: 15), vsync: this)
          ..addListener(
            () {
              setState(() {});
            },
          );

    animation =
        Tween(begin: beginAnim, end: endAnim).animate(animationController);
    startProgress();

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        nextQuestion();
      }
    });
  }

  startProgress() {
    animationController.forward();
  }

  resetProgress() {
    animationController.reset();
  }

  stopAnim() {
    animationController.stop();
  }

  void nextQuestion() {
    if (index < _questions.length - 1) {
      index++;
      resetProgress();
      startProgress();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            score: points,
            totalQuestion: _questions.length,
            correct: correct,
            incorrect: incorrect,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${index + 1}/${_questions.length}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          height: 1.4),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Question",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300, height: 2),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "$points",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          height: 1.4),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Points",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300, height: 2),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            _questions[index].getQuestion() + "?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          LinearProgressIndicator(
            value: animation.value,
          ),
          Container(
            child: CachedNetworkImage(
              imageUrl: _questions[index].getImageUrl(),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_questions[index].getAnswer() == "True") {
                      setState(() {
                        points = points + 20;
                        correct++;
                      });
                    } else {
                      points = points - 5;
                      incorrect++;
                    }
                    nextQuestion();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    alignment: Alignment.center,
                    child: Text(
                      "True",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_questions[index].getAnswer() == "False") {
                      setState(() {
                        points = points + 20;
                        correct++;
                      });
                    } else {
                      points = points - 5;
                      incorrect++;
                    }
                    nextQuestion();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 54,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "False",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
