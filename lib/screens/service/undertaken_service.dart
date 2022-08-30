import 'package:carego_healthcare/widgets/appbar_new.dart';
import 'package:carego_healthcare/widgets/bottom_nav_bar.dart';
import 'package:carego_healthcare/widgets/drawer_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Theme/color.dart';
import '../../Theme/text.dart';

class ServicesUndertaken extends StatelessWidget {
  const ServicesUndertaken({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Upcoming", style: Drawer_Text_Selected()),
                  const Text("Completed"),
                  const Text("Cancelled"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/SVG/female_user.svg",
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Nursing Staff Name"),
                              Text("Date Time"),
                              Text("Post"),
                              Text("Service"),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Payment Status"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavBarNew(),
      ),
    );
  }
}
