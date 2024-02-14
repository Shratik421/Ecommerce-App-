// ignore_for_file: unnecessary_import, avoid_print

// ignore: avoid_web_libraries_in_flutter
import 'dart:js';
import 'dart:ui';
import 'package:ecommerceapp/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerceapp/const/AppColors.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'user_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

TextEditingController emailText = TextEditingController();
TextEditingController passText = TextEditingController();
bool _obcureText = true;

signUp() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailText.text, password: passText.text);
    var authCredential = userCredential.user;
    print(authCredential!.uid);

    if (authCredential.uid.isNotEmpty) {
      Navigator.push(
        context as BuildContext,
        CupertinoPageRoute(
          builder: (_) => const UserForm(),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Something is worng");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'Weak-password') {
      Fluttertoast.showToast(msg: "The PassWord Provided is Too Weak");
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(msg: "The Email is Already Exits in Email.");
    }
  } catch (e) {
    print(e);
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.h,
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
                      const Text(
                        "Welcome Buddy",
                        style: TextStyle(
                            fontSize: 23, color: AppColors.deep_orange),
                      ),
                      const Text(
                        "Glas To see you bcak buddy.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
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
                            child: const Center(
                                child: Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: emailText,
                              decoration: const InputDecoration(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Container(
                          height: 48,
                          width: 41,
                          decoration: BoxDecoration(
                            color: AppColors.deep_orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.lock_clock_outlined,
                            color: Colors.white,
                            size: 12,
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: passText,
                            obscureText: _obcureText,
                            decoration: InputDecoration(
                                hintText: "password must be 6 charater",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                                labelText: "Passsword",
                                labelStyle: const TextStyle(
                                    fontSize: 15, color: AppColors.deep_orange),
                                suffixIcon: _obcureText == true
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obcureText = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obcureText = true;
                                          });
                                        },
                                        icon:
                                            const Icon(Icons.visibility_off))),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {
                                signUp();
                                // String uemail = emailText.text.toString();
                                // String upass = passText.text;
                                // print("Email:$uemail , Pass:$upass");
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  elevation: 3),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              GestureDetector(
                                child: const Text(
                                  "Log In ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deep_orange),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const LoginScreen(),
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
