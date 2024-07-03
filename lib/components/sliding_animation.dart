import 'package:flutter/material.dart';

Widget slidingAnimation(double gridWidth) {
  return AnimatedContainer(
    width: gridWidth,
    height: 50.0,
    duration: const Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
            child: Container(
          height: 20,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.forward, color: Colors.grey),
        ),
      ],
    ),
  );
}