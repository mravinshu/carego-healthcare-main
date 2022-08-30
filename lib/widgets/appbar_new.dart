import 'package:carego_healthcare/screens/service/undertaken_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Theme/color.dart';

class AppBarNew extends StatelessWidget {
  const AppBarNew({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: drawer_icon_back,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 40,
              height: 40,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: drawer_icon_front,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Image(image: AssetImage('assets/images/doctor2.png')),
          Container(
            child: Row(
              children: [
                IconButton(
                    disabledColor: drawer_icon_front,
                    color: drawer_icon_front,
                    onPressed: null,
                    icon: Icon(Icons.monetization_on_outlined)),
                // IconButton(
                //     color: drawer_icon_front,
                //     disabledColor: drawer_icon_front,
                //     onPressed: null,
                //     icon: Icon(Icons.local_shipping_outlined)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/ambulance.svg",
                    color: drawer_icon_front,
                    width: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
