// ignore_for_file: unused_import

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerceapp/const/AppColors.dart';
import 'package:ecommerceapp/ui/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../search_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];

  var _dotPosition = 0;
  var _firestoreInstance = FirebaseFirestore.instance;

  List _products = [];

//fetching carousal images
  fetchCarousalImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousal-slider").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]['img-path'],
        );

        print(qn.docs[i]['img-path']);
      }
    });

    return qn.docs;
  }

//fetching products data
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]['product-name'],
          "product-description": qn.docs[i]['product-desc'],
          "product-price": qn.docs[i]['product-price'],
          "product-img": qn.docs[i]['product-img'],
        });

        //print(qn.docs[i]['img-path']);
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarousalImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Search Products Here",
                    hintStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                  ),
                  onTap: () => Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => const SearchScreen())),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //carousal slider
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: _carouselImages
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(
                              left: 3.0, right: 3.0, top: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _dotPosition = val;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toInt(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_orange,
                  color: AppColors.deep_orange.withOpacity(0.5),
                  spacing: const EdgeInsets.all(2),
                  activeSize: const Size(8, 8),
                  size: const Size(6, 6),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //products data
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(

                      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: Container(
                                color: Colors.yellow,
                                child: Image.network(
                                  _products[index]["product-img"][0],
                                ),
                              ),
                            ),
                            Text("${_products[index]['name']}"),
                            Text("${_products[index]['price'].toString()}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
