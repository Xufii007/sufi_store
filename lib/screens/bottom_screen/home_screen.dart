import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/models/productModel.dart';

import 'package:sufi_store/utils/style.dart';
import 'package:sufi_store/widget/Home_Card.dart';

import '../../widget/Category_home_boxes.dart';
import '../products_details_screen.dart';

// List categories = [
//   'GROCERY',
//   'ELECTRONICES',
//   'COSMETICS',
//   'PHARMECY',
//   'GARMENTS'
// ];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List images = [
    'https://media.istockphoto.com/photos/online-shopping-picture-id923079848?s=612x612',
    'https://media.istockphoto.com/photos/vegetables-and-fruit-in-reusable-bag-on-a-farmers-market-zero-waste-picture-id1159376930?s=612x612',
    'https://media.istockphoto.com/photos/conceptual-photo-of-happy-girl-holds-shopping-packages-on-blue-picture-id1224234335?s=612x612',
    'https://media.istockphoto.com/photos/unrecognizable-woman-marvels-at-grocery-bread-selection-picture-id1041147560?s=612x612',
    'https://media.istockphoto.com/photos/family-with-purchases-in-shop-picture-id1278595262?s=612x612'
  ];
  List<Products> allProducts = [];
  getdata() {
    FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        if (e.exists) {
          setState(() {
            allProducts.add(
              Products(
                  brand: e['brand'],
                  category: e['category'],
                  id: e['id'],
                  productName: e['productName'],
                  detail: e['detail'],
                  serialCode: e['serialCode'],
                  price: e['price'],
                  discountPrice: e['discountPrice'],
                  isOnSale: e['isOnSale'],
                  isPopular: e['isPopular'],
                  isFavourites: e['isFavourites'],
                  imageUrls: e['imageUrls']),
            );
          });
        }
      });
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 22.h,
                child: Column(
                  children: [
                    Container(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: 'XUFI ',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        TextSpan(
                          text: 'STORE',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ])),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const CategoryHomeBoxes(),
                  ],
                ),
              ),
              Container(
                height: 63.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      carousel(images: images),
                      Text(
                        'POPULAR ITEM',
                        style: TextStyle(fontSize: 26),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      allProducts.length == 0
                          ? CircularProgressIndicator()
                          : PopularItmes(allProducts: allProducts),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Center(
                                    child: Text(
                                  'HOT \n SALES',
                                  style: SufiStyle.boldStyle
                                      .copyWith(fontSize: 25),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Center(
                                    child: Text(
                                  'NEW \n ARRIVAL',
                                  style: SufiStyle.boldStyle
                                      .copyWith(fontSize: 25),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'TOP BRANDS',
                        style: TextStyle(fontSize: 26),
                      ),
                      Brands(allProducts: allProducts)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularItmes extends StatelessWidget {
  const PopularItmes({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductsDetailsScreen(
                                          id: e.id,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Image.network(
                              e.imageUrls![0],
                              width: 80,
                              height: 110,
                            ),
                          ),
                        ),
                        Expanded(child: Text(e.productName!)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class Brands extends StatelessWidget {
  const Brands({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxWidth: 80,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.primaries[Random().nextInt(15)]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.brand![0],
                        style: SufiStyle.boldStyle.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class carousel extends StatelessWidget {
  const carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          e,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Colors.blueAccent.withOpacity(0.3),
                            Colors.redAccent.withOpacity(0.3),
                          ]),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 27,
                      left: 30,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'TITLE',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
            .toList(),
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
        ));
  }
}
