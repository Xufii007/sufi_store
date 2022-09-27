import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChekoutScreen extends StatefulWidget {
  const ChekoutScreen({Key? key}) : super(key: key);

  @override
  State<ChekoutScreen> createState() => _ChekoutScreenState();
}

class _ChekoutScreenState extends State<ChekoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('chek out'),
      ),
    );
  }
}
