import 'package:flutter/material.dart';
import 'package:sufi_store/screens/bottom_screen/home_screen.dart';
import 'package:sufi_store/screens/auth_screen/signup_screens.dart';
import 'package:sufi_store/utils/style.dart';
import 'package:sufi_store/widget/sufi_button.dart';

import 'package:sufi_store/widget/sufitextfield.dart';

import '../../services/firebase_services.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              SufiButton(
                title: "Closer",
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      String? accountstatus =
          await FirebaseServices.signInAccount(emailC.text, passwordC.text);
      if (accountstatus != null) {
        ecoDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'WELCOME, \n please login first',
                textAlign: TextAlign.center,
                style: SufiStyle.boldStyle,
              ),
              Column(
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SufiTextField(
                            maxLines: 1,
                          
                            controller: emailC,
                            validate: (v) {
                              if (v!.isEmpty ||
                                  !v.contains("@") ||
                                  !v.contains(".com")) {
                                return "email is badly formated";
                              }
                              return null;
                            },
                            hintText: 'Email....',
                          ),
                          SufiTextField(
                            maxLines: 1,
                          
                            controller: passwordC,
                            hintText: 'Password....',
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'password should not empty';
                              }

                              return null;
                            },
                          ),
                          SufiButton(
                            title: 'LOGIN',
                            isLoading: formStateLoading,
                            isLoginButton: true,
                            onpress: () {
                              submit();
                            },
                          ),
                        ],
                      )),
                ],
              ),
              SufiButton(
                title: 'CREATE NEW ACCOUNT',
                isLoginButton: false,
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SinupScreens()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
