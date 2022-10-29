// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textcolor;
  final String buttonText;
  final buttontapped;
  const MyButtons(
      {this.color,
      this.textcolor,
      required this.buttonText,
      this.buttontapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
