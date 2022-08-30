import 'package:flutter/material.dart';

class DecoratedTextFeildSuffix extends StatefulWidget {
  DecoratedTextFeildSuffix({
    Key? key,
    required this.iconUsed,
    required this.labelUsed,
    required this.controller,
    this.enabled = true,
    this.obsecureText = false,
    this.suffcientIcon = Icons.visibility_outlined,
  }) : super(key: key);
  final IconData iconUsed;
  final String labelUsed;
  final TextEditingController controller;
  IconData suffcientIcon = Icons.visibility_outlined;
  bool enabled = true;
  bool obsecureText = false;

  @override
  State<DecoratedTextFeildSuffix> createState() =>
      _DecoratedTextFeildSuffixState();
}

class _DecoratedTextFeildSuffixState extends State<DecoratedTextFeildSuffix> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obsecureText,
      enabled: widget.enabled,
      controller: widget.controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: widget.labelUsed,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color.fromRGBO(149, 149, 149, 1),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.obsecureText = !widget.obsecureText;
            });
          },
          icon: Icon(widget.suffcientIcon),
          color: Color.fromRGBO(149, 149, 149, 1),
        ),
        prefixIcon: Icon(
          widget.iconUsed,
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
