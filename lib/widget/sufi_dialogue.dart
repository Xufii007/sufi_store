import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sufi_store/widget/sufi_button.dart';

class SufiDialogue extends StatelessWidget {
  final String? title;

  const SufiDialogue({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        SufiButton(
          title: "Closer",
          onpress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
