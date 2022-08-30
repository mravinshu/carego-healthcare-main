import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/widgets/appbar_new.dart';
import 'package:carego_healthcare/widgets/bottom_nav_bar.dart';
import 'package:carego_healthcare/widgets/drawer_user.dart';
import 'package:flutter/material.dart';

class ServiceClicked extends StatefulWidget {
  const ServiceClicked({Key? key}) : super(key: key);

  @override
  State<ServiceClicked> createState() => _ServiceClickedState();
}

class _ServiceClickedState extends State<ServiceClicked> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer_User(height: height),
        backgroundColor: scaffold_back,
        body: Column(
          children: [
            AppBarNew(height: height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: drawer_icon_back,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: height / 12,
                    height: height / 12,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: drawer_icon_front,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          "Book",
                          style: TextStyle(color: drawer_icon_front),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.network(
                'https://rangee.com/wp-content/uploads/2021/06/softwareservice-1.png',
                width: width - 40,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Service Name',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBarNew(),
      ),
    );
  }
}
