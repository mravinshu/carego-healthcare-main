import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/widgets/appbar_new.dart';
import 'package:carego_healthcare/widgets/bottom_nav_bar.dart';
import 'package:carego_healthcare/widgets/drawer_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_user_details.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName = "Loading...";
  void getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("user_name") ?? "Loading...";
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        userName = name;
      });
    });
    // final Response response = await AuthProvider().profile(8.toString());
    // String name = json.decode(response.body)['response']['name'];
    // setState(() {
    //   userName = name;
    // });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

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
            Container(
              height: height / 3.5,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/SVG/male_user.svg",
                        height: height / 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileCard(
                  height: height,
                  title: 'Help',
                ),
                ProfileCard(
                  height: height,
                  title: 'Wallet',
                ),
                ProfileCard(
                  height: height,
                  title: 'Tips',
                ),
              ],
            ),
            ListCardProfile(
              height: height,
              title: 'Messages',
            ),
            ListCardProfile(
              height: height,
              title: 'Referral',
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditUserDetails()));
              },
              child: ListCardProfile(
                height: height,
                title: 'Setting',
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavBarNew(),
      ),
    );
  }
}

class ListCardProfile extends StatelessWidget {
  const ListCardProfile({
    Key? key,
    required this.height,
    required this.title,
  }) : super(key: key);

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: (height / 12) - 5,
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.height,
    required this.title,
  }) : super(key: key);

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
          height: height / 7,
          width: height / 7,
          child: Center(child: Text(title))),
    );
  }
}
