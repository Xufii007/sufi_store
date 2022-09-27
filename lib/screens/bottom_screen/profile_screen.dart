import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/widget/sufi_button.dart';
import 'package:sufi_store/widget/sufitextfield.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //const ProfileScreen({Key? key}) : super(key: key);
  String? profilePic;
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('please profile complete firstly')));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          nameC.text = snapshot['name'];
          phoneC.text = snapshot['phone'];
          houseC.text = snapshot['house'];
          cityC.text = snapshot['city'];
          streetC.text = snapshot['street'];
          addressC.text = snapshot['address'];
          profilePic = snapshot['profilePic'];
        });
      }
    });
    super.initState();
  }

  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              Text(
                'PROFILE',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    final XFile? pickImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if (pickImage != null) {
                      setState(() {
                        profilePic = pickImage.path;
                      });
                    }
                  },
                  child: Container(
                    child: profilePic == null
                        ? CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            radius: 70,
                            child: Image.asset(
                              'assets/c_images/add.png',
                              height: 80,
                              width: 80,
                            ),
                          )
                        : profilePic!.contains('http')
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(profilePic!),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(File(profilePic!)),
                              ),
                  ),
                ),
              ),
              SufiTextField(
                hintText: 'Enter Complete Name',
                controller: nameC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiTextField(
                hintText: 'Enter Phone No',
                controller: phoneC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiTextField(
                hintText: 'Enter House No',
                controller: houseC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiTextField(
                hintText: 'Enter Street',
                controller: streetC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiTextField(
                hintText: 'Enter City',
                controller: cityC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiTextField(
                hintText: 'Enter Complete Adress',
                controller: addressC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Should not be empty';
                  }
                  return null;
                },
              ),
              SufiButton(
                title: nameC.text.isEmpty ? 'Save' : 'Update',
                isLoginButton: true,
                isLoading: isSaving,
                onpress: () {
                  if (formKey.currentState!.validate()) {
                    SystemChannels.textInput.invokeMapMethod('TextInput.hide');
                    profilePic == null
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Select profile pic')))
                        : nameC.text.isEmpty
                            ? saveInfo()
                            : update();
                  }
                },
              ),
              SufiButton(
                title: 'SIGN OUT',
                onpress: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ]),
          ),
        ),
      )),
    );
  }

  String? downloadUrl;
  Future<String?> uploadImage(File filePath, String reference) async {
    try {
      final finaName =
          "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}";
      final Reference fbStorge =
          FirebaseStorage.instance.ref(reference).child(finaName);
      final UploadTask uploadTask = fbStorge.putFile(filePath);

      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorge.getDownloadURL();
      });
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  update() {
    setState(() {
      isSaving = true;
    });

    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': profilePic
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isSaving = false;
        });
      });
    });
  }

  saveInfo() {
    setState(() {
      isSaving = true;
    });

    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': downloadUrl
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isSaving = false;
        });
      });
    });
  }
}
