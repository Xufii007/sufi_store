import 'package:flutter/material.dart';
import 'package:sufi_store/utils/style.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({Key? key}) : super(key: key);
  static const String id = 'deleteproduct';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'DELETE PRODUCT',
          style: SufiStyle.boldStyle,
        ),
      ),
    );
  }
}
