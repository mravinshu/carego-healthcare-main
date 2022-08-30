import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/screens/dashboard/edit_user_details.dart';
import 'package:carego_healthcare/screens/service/undertaken_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carego_healthcare/screens/auth/login.dart';
import '../Theme/text.dart';

String userName = "";

class Drawer_User extends StatefulWidget {
  final double height;
  const Drawer_User({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  State<Drawer_User> createState() => _Drawer_UserState();
}

class _Drawer_UserState extends State<Drawer_User> {
  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("user_name") ?? "Loading...";
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        userName = name;
      });
    });
  }

  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/SVG/male_user.svg",
                      height: widget.height / 7,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userName,
                          style: Drawer_Text(),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditUserDetails()));
                        },
                        child: Icon(Icons.edit))
                  ],
                ),
              ],
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.monetization_on_outlined,
                color: drawer_icon_front,
              ),
              title: Text("Coins")),
          ListTile(
              leading: Icon(
                Icons.insights_outlined,
                color: drawer_icon_front,
              ),
              title: Text("Track")),
          ListTile(
            leading: Icon(
              Icons.history_outlined,
              color: drawer_icon_front,
            ),
            title: Text("Bookings"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServicesUndertaken()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: drawer_icon_front,
            ),
            title: Text("Setting"),
          ),
          ListTile(
            leading: Icon(
              Icons.group_outlined,
              color: drawer_icon_front,
            ),
            title: Text("Refer"),
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline_outlined,
              color: drawer_icon_front,
            ),
            title: Text("About Us"),
          ),
          ListTile(
              leading: Icon(
                Icons.connect_without_contact_outlined,
                color: drawer_icon_front,
              ),
              title: Text("Contact Us")),
          ListTile(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('login', false);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              leading: Icon(
                Icons.logout_outlined,
                color: drawer_icon_front,
              ),
              title: Text("Log Out")),
        ],
      ),
    );
  }
}
