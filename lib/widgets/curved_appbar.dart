import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget {
  const CurvedAppBar({
    Key? key,
    required this.height,
    required this.width,
    required this.titleHeading,
  }) : super(key: key);

  final double height;
  final double width;
  final String titleHeading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Container(
        height: height / 9.128571429,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              titleHeading,
              style: TextStyle(
                fontSize: height / 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text("       "),
          ],
        ),
      ),
    );
  }
}
