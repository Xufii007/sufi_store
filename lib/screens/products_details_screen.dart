import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/models/cartModel.dart';
import 'package:sufi_store/models/productModel.dart';
import 'package:sufi_store/widget/header.dart';
import 'package:sufi_store/widget/sufi_button.dart';

class ProductsDetailsScreen extends StatefulWidget {
  String? id;
  ProductsDetailsScreen({this.id});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  int count = 1;
  List<Products> allProducts = [];
  var newPrice = 0;
  bool isLoading = false;

  getdata() {
    FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.where((element) => element["id"] == widget.id).forEach((e) {
        if (e.exists) {
          for (var item in e['imageUrls']) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Products(
                      id: e["id"],
                      detail: e["detail"],
                      productName: e['productName'],
                      imageUrls: e['imageUrls'],
                      price: e['price'],
                      discountPrice: e['discountPrice']),
                );
              });
            }
          }
        }
        newPrice = allProducts.first.price!;
      });
    });
  }

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favourite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .add({"pid": allProducts.first.id});
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favourite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc(id)
        .delete();
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  bool isfavrt = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: PreferredSize(
                child: Header(
                  title: "${allProducts.first.productName!}",
                ),
                preferredSize: Size.fromHeight(5.h)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    allProducts[0].imageUrls![selectedIndex],
                    height: 25.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          ...List.generate(
                              allProducts[0].imageUrls!.length,
                              (index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Image.network(
                                          allProducts[0].imageUrls![index],
                                          height: 9.h,
                                          width: 9.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 5.5.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "${allProducts.first.price}\$",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("favourite")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("items")
                        .where('pid', isEqualTo: allProducts.first.id)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      }
                      return IconButton(
                          onPressed: () {
                            snapshot.data!.docs.length == 0
                                ? addToFavrourite()
                                : removeToFavrourite(
                                    snapshot.data!.docs.first.id);
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 35,
                            color: snapshot.data!.docs.length == 0
                                ? Colors.black
                                : Colors.red,
                          ));
                    },
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 30.h),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      allProducts.first.detail!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "NOTE: ${allProducts.first.discountPrice} PKR will be applieded when you order more than three item of this product"),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                  if (count > 3) {
                                    newPrice = count *
                                        allProducts.first.discountPrice!;
                                  } else {
                                    newPrice = count * allProducts.first.price!;
                                  }
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        Text(
                          '$count',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                                if (count > 3) {
                                  newPrice =
                                      count * allProducts.first.discountPrice!;
                                } else {
                                  newPrice = count * allProducts.first.price!;
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_plus_1)),
                        SizedBox(
                          width: 6.h,
                        ),
                        Container(
                          height: 5.5.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "${newPrice}\$",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SufiButton(
                    isLoginButton: true,
                    isLoading: isLoading,
                    onpress: () {
                      setState(() {
                        isLoading = true;
                      });
                      Cart.addtoCart(Cart(
                              id: allProducts.first.id,
                              image: allProducts.first.imageUrls!.first,
                              name: allProducts.first.productName,
                              quantity: count,
                              price: newPrice))
                          .whenComplete(() {
                        setState(() {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Added to cart Succcessfully')));
                        });
                      });
                    },
                    title: 'Add to Cart',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
  }
}
