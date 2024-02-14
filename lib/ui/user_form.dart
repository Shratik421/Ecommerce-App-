// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Widget/customButton.dart';
import 'package:ecommerceapp/Widget/myTextfeild.dart';
import 'package:ecommerceapp/const/AppColors.dart';
import 'package:ecommerceapp/ui/bottom_nav_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

TextEditingController _nametext = TextEditingController();
TextEditingController _phonetext = TextEditingController();
TextEditingController _dobtext = TextEditingController();
TextEditingController _gendertext = TextEditingController();
TextEditingController _agetext = TextEditingController();

class _UserFormState extends State<UserForm> {
  List<String> gender = ['Male', 'Female', 'Other'];

//Date Picker
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? Picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (Picked != null) {
      setState(() {
        _dobtext.text = "${Picked.day}/${Picked.month}/${Picked.year}";
      });
    }
  }
  //db = FirebaseFirestore.instance;

  //final user = <String, dynamic>{};

//send user data to database
  sendUserDataTodB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    var currentUser = _auth.currentUser;

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    try {
      return await collectionRef
          .doc(currentUser!.email)
          .set({
            "name": _nametext.text,
            "phone": _phonetext.text,
            "dob": _dobtext.text,
            "gender": _gendertext.text,
            "age": _agetext.text,
          })
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const BottomNavController())))
          .catchError((error) => print("Soemething was wrong : $error"));
    } catch (error) {
      print("Error writing document: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Submit The form to Continue.",
                  style: TextStyle(fontSize: 22, color: AppColors.deep_orange),
                ),
                const Text(
                  "We will not share your information with anymore.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 15,
                ),
                myTextfeild("Enter your Name", TextInputType.text, _nametext),

                myTextfeild(
                    "Enter Your Phone No", TextInputType.text, _phonetext),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: _dobtext,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Enter Your Date Of Birth",
                      suffixIcon: IconButton(
                        onPressed: () => _selectDateFromPicker(context),
                        icon: const Icon(Icons.calendar_today_outlined),
                      )),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _gendertext,
                  decoration: InputDecoration(
                    hintText: "Select Gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: () {
                              setState(
                                () {
                                  _gendertext.text = value;
                                },
                              );
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),

                myTextfeild("Enter Your Age", TextInputType.number, _agetext),

                const SizedBox(
                  height: 50,
                ),

                // customButton("Continue", (){
                //   sendUserDataTodB();
                // }),
                SizedBox(
                  height: 56,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        sendUserDataTodB();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deep_orange,
                        elevation: 3,
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
