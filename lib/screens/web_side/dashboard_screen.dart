import 'package:flutter/material.dart';
import 'package:sufi_store/utils/style.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static const String id = 'dashboard';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'DASHBOARD',
          style: SufiStyle.boldStyle,
        ),
      ),
    );
  }
}
