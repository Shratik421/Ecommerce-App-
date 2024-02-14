// ignore_for_file: camel_case_types, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Widget/fetchProducts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: fetchData("user-favourite-item"),
      ),
    );
  }
}
