// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var userQuestions = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Calculator',
          style: TextStyle(fontSize: 23),
        ),
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      userQuestions,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1) {
                          return MyButtons(
                            buttontapped: () {
                              setState(() {
                                userQuestions = userQuestions.substring(
                                    0, userQuestions.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Color.fromARGB(255, 154, 13, 13),
                            textcolor: Color.fromARGB(255, 238, 254, 252),
                          );
                        } else if (index == 0) {
                          return MyButtons(
                            buttontapped: () {
                              setState(() {
                                userQuestions = '';
                                userAnswer = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Color.fromARGB(255, 40, 31, 203),
                            textcolor: Color.fromARGB(255, 238, 254, 252),
                          );
                        } else if (index == buttons.length - 1) {
                          return MyButtons(
                            buttontapped: () {
                              setState(() {
                                String finalQuestion = userQuestions;
                                finalQuestion =
                                    finalQuestion.replaceAll('x', '*');
                                Parser p = Parser();
                                Expression exp = p.parse(finalQuestion);
                                ContextModel cm = ContextModel();
                                double eval =
                                    exp.evaluate(EvaluationType.REAL, cm);
                                userAnswer = eval.toString();
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.deepPurple[50],
                            textcolor: Colors.deepPurple,
                          );
                        } else {
                          return MyButtons(
                            buttontapped: () {
                              setState(() {
                                userQuestions += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Color.fromARGB(255, 91, 58, 183)
                                : Colors.deepPurple[50],
                            textcolor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                          );
                        }
                      }))),
        ],
      ),
    );
    // ignore: dead_code
    //void equalPressed() {
    String finalQuestion = userQuestions;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}

bool isOperator(String x) {
  if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}
