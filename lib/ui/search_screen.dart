// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SeacrhScreenState();
}

class _SeacrhScreenState extends State<SearchScreen> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (val) {
                  setState(
                    () {
                      inputText = val;
                      print(inputText);
                    },
                  );
                },
              ),
              Expanded(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .where("product-name",
                              isGreaterThanOrEqualTo: inputText)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Something Wents Wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Text("Loading"),
                          );
                        }
                        return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text(data['product-name']),
                          );
                        }).toList());
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
