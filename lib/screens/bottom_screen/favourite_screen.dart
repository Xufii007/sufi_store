import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/screens/products_details_screen.dart';
import 'package:sufi_store/widget/header.dart';

class FavrouriteScreen extends StatefulWidget {
  const FavrouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavrouriteScreen> createState() => _FavrouriteScreenState();
}

class _FavrouriteScreenState extends State<FavrouriteScreen> {
  List ids = [];
  getId() {
    FirebaseFirestore.instance
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element['pid']);
        });
      });
    });
  }

  @override
  initState() {
    getId();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: Header(
          title: "FAVOURITE",
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.data == null) {
              return Center(child: Text("No Favourite item found"));
            }
            List<QueryDocumentSnapshot<Object?>> fp = snapshot.data!.docs
                .where((element) => ids.contains(['id']))
                .toList();
            return ListView.builder(
              itemCount: fp.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductsDetailsScreen(
                                    id: fp[index]['id'],
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(fp[index]['productName']),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.navigate_next_outlined,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
