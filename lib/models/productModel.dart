import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? id;
  String? productName;
  String? detail;
  String? serialCode;
  int? price;
  String? brand;
  int? discountPrice;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavourites;
  List<dynamic>? imageUrls;
  Products({
       this.category,
       this.id,
       this.productName,
       this.brand,
       this.detail,
       this.serialCode,
       this.price,
       this.discountPrice,
       this.isOnSale,
       this.isPopular,
       this.isFavourites,
       this.imageUrls});

  static Future<void> addProducts(Products products) async {
    CollectionReference db = FirebaseFirestore.instance.collection('products');
    Map<String, dynamic> data = {
      "category": products.category,
      "id": products.id,
      "productName": products.productName,
      "detail": products.detail,
      "price": products.price,
      "brand":products.brand,
      "discountPrice": products.discountPrice,
      "serialCode": products.serialCode,
      "imageUrls": products.imageUrls,
      "isOnSale": products.isOnSale,
      "isFavourites": products.isFavourites,
      "isPopular": products.isPopular,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(String id, Products updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection('products');

    Map<String, dynamic> data = {
      "category": updateProducts.category,
      "id": updateProducts.id,
      "productName": updateProducts.productName,
      "detail": updateProducts.detail,
      "brand":updateProducts.brand,

      "price": updateProducts.price,
      "discountPrice": updateProducts.discountPrice,
      "serialCode": updateProducts.serialCode,
      "imageUrls": updateProducts.imageUrls,
      "isOnSale": updateProducts.isOnSale,
      "isFavourites": updateProducts.isFavourites,
      "isPopular": updateProducts.isPopular,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProducts(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection('products');

    await db.doc(id).delete();
  }
}
