import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sufi_store/screens/bottom_screen/cart_screen.dart';
import 'package:sufi_store/screens/bottom_screen/chekout_screen.dart';
import 'package:sufi_store/screens/bottom_screen/favourite_screen.dart';
import 'package:sufi_store/screens/bottom_screen/home_screen.dart';
import 'package:sufi_store/screens/bottom_screen/product_screen.dart';
import 'package:sufi_store/screens/bottom_screen/profile_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;

  void cartItemLength() {
    FirebaseFirestore.instance.collection('cart').get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        setState(() {
          length = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItemLength();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shop)),
          BottomNavigationBarItem(
              icon: Stack(
            children: [
              Icon(Icons.add_shopping_cart),
              Positioned(
                  top: 1,
                  right: 2,
                  child: length == 0
                      ? Container()
                      : Stack(
                          children: [
                            Icon(
                              Icons.brightness_1,
                              size: 22,
                              color: Colors.green,
                            ),
                            Positioned.fill(
                              bottom: 4,
                              right: 6,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '$length',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ))
            ],
          )),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: HomeScreen());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProductScreen());
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: CartScreen());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: FavrouriteScreen());
              }));
            case 4:
              if (FirebaseAuth.instance.currentUser!.displayName != null) {
                return CupertinoTabView(builder: ((context) {
                  return CupertinoPageScaffold(child: ProfileScreen());
                }));
              }
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ChekoutScreen());
              }));
            case 5:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProfileScreen()); 
              }));

            default:
          }
          return HomeScreen();
        });
  }
}
