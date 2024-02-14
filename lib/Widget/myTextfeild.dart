import 'package:flutter/material.dart';

Widget myTextfeild(String hintText, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
    ),
  );
}
