import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/screens/bottom_screen/product_screen.dart';

import '../models/category_models.dart';
import '../screens/bottom_screen/home_screen.dart';

class CategoryHomeBoxes extends StatelessWidget {
  const CategoryHomeBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProductScreen(
                            category:categories[index].title!,
                          )));
                    },
                    child: Container(
                      height: 12.h,
                      width: 15.w,
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("${categories[index].image}")),
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 5,
                          //     spreadRadius: 3,
                          //     color: Colors.red.withOpacity(0.5),
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    categories[index].title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
