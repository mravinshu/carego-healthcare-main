import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/screens/dashboard/dashboard.dart';
import 'package:carego_healthcare/screens/dashboard/profile.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../screens/service/service_drop.dart';

int selectedIndex = 0;

class BottomNavBarNew extends StatefulWidget {
  const BottomNavBarNew({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBarNew> createState() => _BottomNavBarNewState();
}

class _BottomNavBarNewState extends State<BottomNavBarNew> {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      items: <SalomonBottomBarItem>[
        SalomonBottomBarItem(
          selectedColor: service_icon,
          icon: const Icon(Icons.dashboard),
          title: const Text("Home"),
        ),
        SalomonBottomBarItem(
          selectedColor: service_icon,
          icon: const Icon(Icons.business),
          title: const Text("Services"),
        ),
        SalomonBottomBarItem(
          selectedColor: service_icon,
          icon: const Icon(Icons.person),
          title: const Text("Me"),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: bottomnavsel,
      onTap: (index) {
        // print(index);
        setState(() {
          selectedIndex = index;
          if (index == 0) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dashboard(
                        alreadyBuild: true,
                      )),
            );
          } else if (index == 1) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServiceDropDown()),
            );
          } else if (index == 2) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          }
        });
      },
    );
  }
}
