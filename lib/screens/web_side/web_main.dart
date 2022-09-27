import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sufi_store/screens/web_side/addproduct_screen.dart';
import 'package:sufi_store/screens/web_side/dashboard_screen.dart';
import 'package:sufi_store/screens/web_side/deleteproduct_screen.dart';
import 'package:sufi_store/screens/web_side/updateproduct_screen.dart';

class WebLoginMain extends StatefulWidget {
  //const WebLoginMain({Key? key}) : super(key: key);
  static const String id = 'webmain';

  @override
  State<WebLoginMain> createState() => _WebLoginMainState();
}

class _WebLoginMainState extends State<WebLoginMain> {
  Widget selectedScreen = const DashBoardScreen();

  choseScreen(item) {
    switch (item) {
      case DashBoardScreen.id:
        setState(() {
          selectedScreen = DashBoardScreen();
        });

        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = const DeleteProductScreen();
        });

        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = const AddProductScreen();
        });

        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Admin'),
        ),
        sideBar: SideBar(
            backgroundColor: Colors.black,
            textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            onSelected: (item) {
              choseScreen(item.route);
            },
            items: const [
              AdminMenuItem(
                title: 'DASHBOARD',
                icon: Icons.dashboard,
                route: DashBoardScreen.id,
              ),
              AdminMenuItem(
                title: 'ADD PRODUCT',
                icon: Icons.add,
                route: AddProductScreen.id,
              ),
              AdminMenuItem(
                title: 'UPDATE PRODUCT',
                icon: Icons.update,
                route: UpdateProductScreen.id,
              ),
              AdminMenuItem(
                title: 'DELETE PRODUCT',
                icon: Icons.delete,
                route: DeleteProductScreen.id,
              ),
              AdminMenuItem(
                title: 'CART ITEM',
                icon: Icons.shop,
              ),
            ],
            selectedRoute: WebLoginMain.id),
        body: Center(
          child: selectedScreen,
        ));
  }
}
