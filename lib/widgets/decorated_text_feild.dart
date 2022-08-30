import 'package:flutter/material.dart';

class DecoratedTextFeild extends StatelessWidget {
  DecoratedTextFeild({
    Key? key,
    required this.iconUsed,
    required this.labelUsed,
    required this.controller,
    this.enabled = true,
    this.suffcientIcon = Icons.visibility_outlined,
  }) : super(key: key);
  final IconData iconUsed;
  final String labelUsed;
  final TextEditingController controller;
  IconData suffcientIcon = Icons.visibility_outlined;
  bool enabled = true;
  bool suffixVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: labelUsed,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color.fromRGBO(149, 149, 149, 1),
        ),
        prefixIcon: Icon(
          iconUsed,
          color: Color.fromRGBO(149, 149, 149, 1),
          size: 24,
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.black,
    //     borderRadius: BorderRadius.circular(32),
    //   ),
    //   child: const TextField(
    //     decoration: InputDecoration(
    //       hintStyle: TextStyle(fontSize: 17),
    //       hintText: 'Name',
    //       prefixIcon: Icon(Icons.search),
    //       border: InputBorder.none,
    //       contentPadding: EdgeInsets.all(20),
    //     ),
    //   ),
    // );
  }
}
