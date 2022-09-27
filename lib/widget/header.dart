import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String? title;
  Header({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        title!,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
