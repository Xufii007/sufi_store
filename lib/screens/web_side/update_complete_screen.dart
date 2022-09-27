import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/models/productModel.dart';
import 'package:sufi_store/screens/bottom_screen/home_screen.dart';
import 'package:sufi_store/utils/style.dart';
import 'package:sufi_store/widget/sufiTextField.dart';
import 'package:sufi_store/widget/sufi_button.dart';
import 'package:uuid/uuid.dart';

import '../../models/category_models.dart';

class UpdateCompleteScreen extends StatefulWidget {
  String? id;
  Products? products;
  UpdateCompleteScreen({Key? key, this.id, this.products}) : super(key: key);

  @override
  State<UpdateCompleteScreen> createState() => _UpdateCompleteScreenState();
}

class _UpdateCompleteScreenState extends State<UpdateCompleteScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController brandC = TextEditingController();


  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourites = false;

  String? selectedValue = "";
  bool isSaving = false;
  bool isUploading = false;

  final imagePiker = ImagePicker();
  List<XFile> images = [];
  List<dynamic> imageUrls = [];
  var uuid = Uuid();

  @override
  void initState() {
    selectedValue = widget.products!.category!;
    productNameC.text = widget.products!.productName!;
    detailC.text = widget.products!.detail!;
    priceC.text = widget.products!.price!.toString();
    discountPriceC.text = widget.products!.discountPrice!.toString();
    serialCodeC.text = widget.products!.serialCode!;
    isOnSale = widget.products!.isOnSale!;
    isPopular = widget.products!.isPopular!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Text(
                    'UPDATE PRODUCTS',
                    style: SufiStyle.boldStyle,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: DropdownButtonFormField(
                        hint: Text('Chose category'),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null) {
                            return 'category must be selected';
                          }
                        },
                        value: selectedValue,
                        items: categories
                            .map((e) => DropdownMenuItem<String>(
                                value: e.title, child: Text(e.title!)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        }),
                  ),
                  SufiTextField(
                    controller: productNameC,
                    hintText: 'Enter Product Name....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  SufiTextField(
                    maxLines: 5,
                    controller: detailC,
                    hintText: 'Enter Product Detail....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  SufiTextField(
                    controller: priceC,
                    hintText: 'Enter Product Price....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  SufiTextField(
                    controller: discountPriceC,
                    hintText: 'Enter Product discount Price....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  SufiTextField(
                    controller: serialCodeC,
                    hintText: 'Enter Product Serial Code....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  SufiTextField(
                    controller: brandC,
                    hintText: 'Enter Product brand....',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemCount: widget.products!.imageUrls!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Image.network(
                                    widget.products!.imageUrls![index],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.products!.imageUrls!
                                            .removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined)),
                              ],
                            ),
                          );
                        }),
                  ),
                  SufiButton(
                    title: 'PICK IMAGE',
                    onpress: () {
                      pickImage();
                    },
                    isLoginButton: true,
                  ),
                  // SufiButton(
                  //   title: 'UPLOAD IMAGE',
                  //   isLoading: isUploading,
                  //   onpress: () {
                  //     uploadImages();
                  //   },
                  //   isLoginButton: true,
                  // ),
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Image.network(
                                    File(images[index].path).path,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        images.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined)),
                              ],
                            ),
                          );
                        }),
                  ),
                  SwitchListTile(
                      title: Text('Is this product On Sale'),
                      value: isOnSale,
                      onChanged: (v) {
                        setState(() {
                          isOnSale = !isOnSale;
                        });
                      }),
                  SwitchListTile(
                      title: Text('Is this product Popular'),
                      value: isPopular,
                      onChanged: (v) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      }),
                  SufiButton(
                    title: 'SAVE',
                    onpress: () {
                      save();
                    },
                    isLoading: isSaving,
                    isLoginButton: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.updateProducts(
            widget.id!,
            Products(
                brand: brandC.text,
                category: selectedValue,
                id: widget.id!,
                productName: productNameC.text,
                detail: detailC.text,
                serialCode: serialCodeC.text,
                price: int.parse(priceC.text),
                discountPrice: int.parse(discountPriceC.text),
                isOnSale: isOnSale,
                isPopular: isPopular,
                isFavourites: isFavourites,
                imageUrls: imageUrls))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        imageUrls.clear();
        images.clear();
        clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('ADDED SUCCESSFULLY')));
      });
    });
    // await FirebaseFirestore.instance
    //     .collection('products')
    //     .add({"image": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    // });
  }

  clearField() {
    setState(() {
      // selectedValue = "";
      productNameC.clear();
      detailC.clear();
      priceC.clear();
      discountPriceC.clear();
      serialCodeC.clear();
    });
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePiker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print('no image selected');
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child('images').child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downLoadUrl) => imageUrls.add(downLoadUrl));
    }
    imageUrls.addAll(widget.products!.imageUrls!);
  }
}
