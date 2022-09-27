import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sufi_store/screens/web_side/landing_screen.dart';
import 'package:sufi_store/screens/layout_screen.dart';
import 'package:sufi_store/screens/auth_screen/login_screens.dart';
import 'package:sizer/sizer.dart';
import 'package:sufi_store/screens/web_side/addproduct_screen.dart';
import 'package:sufi_store/screens/web_side/dashboard_screen.dart';
import 'package:sufi_store/screens/web_side/deleteproduct_screen.dart';
import 'package:sufi_store/screens/web_side/updateproduct_screen.dart';
import 'package:sufi_store/screens/web_side/web_login.dart';
import 'package:sufi_store/screens/web_side/web_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCdWHFaFtIIKbu5785rCVaULPvSEW--fgc",
          authDomain: "sufi-store.firebaseapp.com",
          projectId: "sufi-store",
          storageBucket: "sufi-store.appspot.com",
          messagingSenderId: "411616003785",
          appId: "1:411616003785:web:c2b2029a334de443a46f18"),
    );
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        title: 'SUFI STORE',
        home: LayoutScreen(),
        routes: {
          WebLogin.id: (context) => WebLogin(),
          WebLoginMain.id: (context) => WebLoginMain(),
          AddProductScreen.id: (context) => AddProductScreen(),
          UpdateProductScreen.id: (context) => UpdateProductScreen(),
          DeleteProductScreen.id: (context) => DeleteProductScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
        },
      ),
    );
  }
}
