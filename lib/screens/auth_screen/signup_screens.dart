import 'package:flutter/material.dart';
import 'package:sufi_store/screens/auth_screen/login_screens.dart';
import 'package:sufi_store/services/firebase_services.dart';
import 'package:sufi_store/utils/style.dart';
import 'package:sufi_store/widget/sufiTextField.dart';
import 'package:sufi_store/widget/sufi_button.dart';

class SinupScreens extends StatefulWidget {
  @override
  State<SinupScreens> createState() => _SinupScreensState();
}

class _SinupScreensState extends State<SinupScreens> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypepasswordC = TextEditingController();

  FocusNode? passwordfosus;
  FocusNode? retypepasswordfosus;
  final formkey = GlobalKey<FormState>();

  bool ispassword = true;
  bool isretypepassword = true;
  bool formStateLoading = false;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypepasswordC.dispose();
    super.dispose();
  }

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
      if (passwordC.text == retypepasswordC.text) {
        setState(() {
          formStateLoading = true;
        });
        String? accountstatus =
            await FirebaseServices.createAccount(emailC.text, passwordC.text);
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }
        //  Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => LoginScreens()));

      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'WELCOME, \n please Create your Account',
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
                            controller: emailC,
                            chek: true,
                            validate: (v) {
                              if (v!.isEmpty ||
                                  !v.contains("@") ||
                                  !v.contains(".com")) {
                                return "email is badly formated";
                              }
                              return null;
                            },
                            inputAction: TextInputAction.next,
                            hintText: 'Email....',
                            icon: const Icon(Icons.email),
                          ),
                          SufiTextField(
                            maxLines: 1,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                             inputAction: TextInputAction.next,
                            focusNode: passwordfosus,
                            ispassword: ispassword,
                            controller: passwordC,
                            hintText: 'Password....',
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispassword = !ispassword;
                                  });
                                },
                                icon: ispassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          SufiTextField(
                            maxLines: 1,
                            ispassword: isretypepassword,
                            controller: retypepasswordC,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                            hintText: ' Retype Password....',
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isretypepassword = !isretypepassword;
                                  });
                                },
                                icon: isretypepassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          SufiButton(
                            title: 'SIGNUP',
                            isLoginButton: true,
                            onpress: () {
                              submit();
                            },
                            isLoading: formStateLoading,
                          ),
                        ],
                      )),
                ],
              ),
              SufiButton(
                title: 'Back to Login',
                isLoginButton: false,
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
