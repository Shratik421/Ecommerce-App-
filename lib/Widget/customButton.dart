import 'package:ecommerceapp/const/AppColors.dart';
// ignore: unused_import
import 'package:ecommerceapp/ui/registration_screen.dart';
import 'package:flutter/material.dart';

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 1.5,
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      // ignore: sort_child_properties_last
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deep_orange,
        elevation: 3,
      ),
    ),
  );
}
