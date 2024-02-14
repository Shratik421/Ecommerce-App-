import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget fetchData(
  String collectionName,
) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('items')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        print("Error: ${snapshot.error}");
        return const Center(
          child: Text("Something is Wrong"),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (_, index) {
          DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: Text(_documentSnapshot['name']),
              title: Text(
                "\$ ${_documentSnapshot['price']}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              trailing: GestureDetector(
                child: const CircleAvatar(
                  child: Icon(Icons.remove_circle),
                ),
                onTap: () {
                  FirebaseFirestore.instance
                      .collection(collectionName)
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection("items")
                      .doc(_documentSnapshot.id)
                      .delete();
                },
              ),
            ),
          );
        },
      );
    },
  );
}
