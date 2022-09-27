import 'package:flutter/material.dart';
import 'package:sufi_store/utils/style.dart';

class HomeCard extends StatelessWidget {
  final String? title;
  const HomeCard({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [
            Colors.blueAccent.withOpacity(0.8),
            Colors.redAccent.withOpacity(0.8),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            title ?? "TITLE",
            style: SufiStyle.boldStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
