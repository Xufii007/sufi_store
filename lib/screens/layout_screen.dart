import 'package:flutter/cupertino.dart';
import 'package:sufi_store/screens/web_side/landing_screen.dart';
import 'package:sufi_store/screens/web_side/web_login.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return WebLogin();
        } else {
          return LandingScreen();
        }
      },
    );
  }
}
