import 'package:flutter/material.dart';
import 'QuestionBank.dart';

QuestionBank questionBank = QuestionBank();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Quiz(),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  List<Icon> scorekeeper = [];
  Widget build(BuildContext context) {
    void setIcons({icon, color}) {
      scorekeeper.add(Icon(
        icon,
        color: color,
      ));
    }

    void result(bool ans) {
      if (ans == questionBank.getList().ans) {
        setIcons(icon: Icons.check, color: Colors.green);
        print("user got it right");
      } else {
        setIcons(icon: Icons.close, color: Colors.green);
        print("user got it wrong");
      }
    }

    if (questionBank.getNum() == -1) {
      scorekeeper = [];
    }
    String text() {
      if (questionBank.getNum() == -1)
        return "THE END";
      else {
        return questionBank.getList().ques;
      }
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    text(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
              onPressed: () {
                setState(() {
                  result(true);
                  questionBank.getNext();
                });
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  result(false);
                  questionBank.getNext();
                });
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )),
          SizedBox(
            height: 30,
          ),
          Row(
            children: scorekeeper,
          )
        ],
      ),
    );
  }
}
