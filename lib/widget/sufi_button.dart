import 'package:flutter/material.dart';

class SufiButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onpress;
  bool? isLoading;
  SufiButton({
    Key? key,
    this.title,
    this.isLoginButton = false,
    this.onpress,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoginButton == false ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isLoginButton == false ? Colors.black : Colors.black,
          ),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading! ? false : true,
              child: Center(
                child: Text(
                  title ?? 'button',
                  style: TextStyle(
                    color: isLoginButton == false ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading!,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
