import 'package:flutter/material.dart';

import '../Theme/color.dart';
import '../Theme/text.dart';

class HeadingName extends StatefulWidget {
  const HeadingName({
    Key? key,
    required this.width,
    required this.name,
    required this.isSearch,
  }) : super(key: key);

  final double width;
  final String name;
  final bool isSearch;

  @override
  State<HeadingName> createState() => _HeadingNameState();
}

class _HeadingNameState extends State<HeadingName> {
  double widthCard = 200;
  double widthIcon = 40;
  bool isTapped = false;
  void changeWidth() {
    setState(() {
      widthCard = widget.width / 2.4;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      changeWidth();
    });
    changeWidth();
  }

  @override
  Widget build(BuildContext context) {
    return isTapped
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: widget.width - widget.width / 6.75,
              decoration: BoxDecoration(
                  color: drawer_icon_back,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search Category",
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: drawer_icon_front,
                      ),
                      onPressed: () {
                        setState(() {
                          widthCard = widget.width / 2;
                          widthIcon = 40;
                          isTapped = false;
                        });
                      },
                    ),
                    prefixIcon: Icon(
                      Icons.category,
                      color: drawer_icon_front,
                    ),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                    border: InputBorder.none),
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: drawer_icon_back,
                child: AnimatedContainer(
                  width: widthCard,
                  duration: Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.category,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.name,
                          style: Heading(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.isSearch
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: drawer_icon_back,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: widthIcon,
                        height: 40,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: drawer_icon_front,
                          ),
                          onPressed: () {
                            setState(() {
                              widthCard = 0;
                              widthIcon = widget.width - widget.width / 6.75;
                              Future.delayed(const Duration(milliseconds: 500),
                                  (() {
                                setState(() {
                                  isTapped = true;
                                });
                              }));
                            });
                          },
                        ),
                      ),
                    )
                  : Text(""),
            ],
          );
  }
}
