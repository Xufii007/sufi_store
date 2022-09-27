import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/widget/header.dart';

class CartScreen extends StatelessWidget {
  // const CartScreen({Key? key}) : super(key: key);
  CollectionReference db = FirebaseFirestore.instance.collection('cart');

  delete(String id, BuildContext context) {
    db.doc(id).delete().then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successfullu delete'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Header(
          title: 'CART ITEMS',
        ),
        preferredSize: Size.fromHeight(7.h),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final res = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 3,
                          spreadRadius: 3,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          res['image'],
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${res['productName']}'),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Qty : '),
                                        Container(
                                            alignment: Alignment.center,
                                            color: Colors.black,
                                            constraints: BoxConstraints(
                                              minWidth: 30,
                                              minHeight: 20,
                                              maxHeight: 20,
                                              maxWidth: 30,
                                            ),
                                            child: Text(
                                              '${res['quantity']}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Row(
                                      children: [
                                        Text('Price : '),
                                        Text('${res['price']}')
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            delete(res.id, context);
                          },
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}