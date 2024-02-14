// ignore_for_file: unused_import

import 'dart:js';
import 'dart:ui';

import 'package:ecommerceapp/Widget/customButton.dart';
import 'package:ecommerceapp/const/AppColors.dart';
import 'package:ecommerceapp/ui/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bottom_nav_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailText = TextEditingController();
TextEditingController passText = TextEditingController();
bool _obcureText = true;

login(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailText.text, password: passText.text);
    var authCredential = userCredential.user;
    print("Page get credentials");
    print(authCredential!.uid);

    if (authCredential.uid.isNotEmpty) {
      print("going to HomePage");
      Navigator.of(context as BuildContext).push(
        CupertinoPageRoute(
          builder: (context) => BottomNavController(),
        ),
      );
    } else {
      print("Not going to HomePage");
      Fluttertoast.showToast(msg: "Something is worng");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(msg: "The User Not found");
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: "The PassWord Provided is Wrong.");
    }
  } catch (e) {
    print(e);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              "Log In",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Welcome Buddy",
                        style: TextStyle(
                            fontSize: 23, color: AppColors.deep_orange),
                      ),
                      Text(
                        "Glas To see you bcak buddy.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: emailText,
                              decoration: InputDecoration(
                                hintText: "Enter the Email",
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 15, color: AppColors.deep_orange),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 41,
                            decoration: BoxDecoration(
                              color: AppColors.deep_orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Icon(
                              Icons.lock_clock_outlined,
                              color: Colors.white,
                              size: 12,
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: passText,
                              obscureText: _obcureText,
                              decoration: InputDecoration(
                                hintText: "password must be 6 charater",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                                labelText: "Passsword",
                                labelStyle: TextStyle(
                                    fontSize: 15, color: AppColors.deep_orange),
                                suffixIcon: _obcureText == true
                                    ? IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              _obcureText = false;
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              _obcureText = true;
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.visibility_off),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),

                      //elevated button

                      // customButton("Log In", () {
                      //   login(context);
                      // },),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {
                                login(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 15,
                      ),
                      Center(
                        child: Container(
                          child: Wrap(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Sign Up ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deep_orange),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
