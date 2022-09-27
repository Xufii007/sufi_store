import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sufi_store/models/productModel.dart';
import 'package:sufi_store/screens/web_side/update_complete_screen.dart';

import 'package:sufi_store/utils/style.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);
  static const String id = 'updateproduct';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const Text(
              'UPDATE PRODUCT',
              style: SufiStyle.boldStyle,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('NO DATA EXIST'),
                  );
                }
                final data = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: ListTile(
                                title: Text(
                                  data[index]["productName"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Container(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (_) {
                                            //   return UpdateCompleteScreen(

                                            //   );
                                            // }));
                                            Products.deleteProducts(
                                                data[index].id);
                                          },
                                          icon: const Icon(Icons.delete_forever,
                                              color: Colors.white)),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return UpdateCompleteScreen(
                                                id: data[index].id,
                                                products: Products(
                                                   brand: data[index]
                                                        ['brand'],
                                                    category: data[index]
                                                        ['category'],
                                                    id: id,
                                                    productName: data[index]
                                                        ['productName'],
                                                    detail: data[index]
                                                        ['detail'],
                                                    serialCode: data[index]
                                                        ['serialCode'],
                                                    price: data[index]['price'],
                                                    discountPrice: data[index]
                                                        ['discountPrice'],
                                                    isOnSale: data[index]
                                                        ['isOnSale'],
                                                    isPopular: data[index]
                                                        ['isPopular'],
                                                    isFavourites: data[index]
                                                        ['isFavourites'],
                                                    imageUrls: data[index]
                                                        ['imageUrls']),
                                              );
                                            }));
                                          },
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
