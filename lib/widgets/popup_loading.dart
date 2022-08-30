import 'package:flutter/material.dart';

class PopUpLoading extends StatelessWidget {
  const PopUpLoading({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.message,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 3.491803279,
      width: width / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    );
  }
}
