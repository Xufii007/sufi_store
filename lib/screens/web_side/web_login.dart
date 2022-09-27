import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/screens/web_side/web_main.dart';
import 'package:sufi_store/services/firebase_services.dart';
import 'package:sufi_store/utils/style.dart';
import 'package:sufi_store/widget/sufi_button.dart';
import 'package:sufi_store/widget/sufi_dialogue.dart';
import 'package:sufi_store/widget/sufitextfield.dart';

class WebLogin extends StatefulWidget {
  WebLogin({Key? key}) : super(key: key);

  static const String id = 'weblogin';

  @override
  State<WebLogin> createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  TextEditingController userNameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool formStateLoding = false;

  submit(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoding = true;
      });
      await FirebaseServices.adminSignIn(userNameC.text).then((value) async {
        if (value['username'] == userNameC.text &&
            value['password'] == passwordC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.pushReplacementNamed(context, WebLoginMain.id);
            }
          } catch (e) {
            setState(() {
              formStateLoding = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return SufiDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 3)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WELCOME ADMIN',
                      style: SufiStyle.boldStyle,
                    ),
                    const Text(
                      'Login to your account',
                      style: SufiStyle.boldStyle,
                    ),
                    SufiTextField(
                      controller: userNameC,
                      hintText: 'UserName',
                      validate: (v) {
                        if (v!.isEmpty) {
                          return 'Email should not be empty';
                        }

                        return null;
                      },
                    ),
                    SufiTextField(
                      controller: passwordC,
                      ispassword: true,
                      hintText: 'password...',
                      validate: (v) {
                        if (v!.isEmpty) {
                          return 'password should not be empty';
                        }

                        return null;
                      },
                    ),
                    SufiButton(
                      isLoginButton: true,
                      isLoading: formStateLoding,
                      onpress: () {
                        submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
