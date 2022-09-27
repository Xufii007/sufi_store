import 'package:flutter/material.dart';

class SufiTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool ispassword;
  Widget? icon;
  bool chek;
  int? maxLines;
  int? minLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;

  SufiTextField({
    this.hintText,
    this.controller,
    this.validate,
    this.ispassword = false,
    this.chek = false,
    this.icon,
    this.maxLines,
    this.minLines,
    this.inputAction,
    this.focusNode,
  });

  @override
  State<SufiTextField> createState() => _SufiTextFieldState();
}

class _SufiTextFieldState extends State<SufiTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: TextFormField(
        minLines: widget.minLines == 1 ? 1 : widget.minLines,
        maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        controller: widget.controller,
        validator: widget.validate,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        // obscureText: widget.ispassword ? true : false,
        decoration: InputDecoration(
            suffixIcon: widget.icon,
            border: InputBorder.none,
            hintText: widget.hintText ?? 'Hint text....',
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
