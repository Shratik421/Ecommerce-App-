// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController? _nameController;
  // TextEditingController? _genderController ;
  TextEditingController? _phoneController;
  // TextEditingController ?_dobController ;
  TextEditingController? _ageController;

  setDataToTextFeild(data) {
    return Column(
      children: [
        TextField(
          controller: _nameController =
              TextEditingController(text: data['name']),
        ),
        TextField(
          controller: _phoneController =
              TextEditingController(text: data['phone']),
        ),
        TextField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        ElevatedButton(
          onPressed: () => updateData(data),
          child: const Text("Update"),
        ),
      ],
    );
  }

  updateData(data) {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");

    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "phone": _phoneController!.text,
      "age": _ageController!.text,
    }).then((value) => print("updated Succeefully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;

            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return setDataToTextFeild(data);
          },
        ),
      )),
    );
  }
}
