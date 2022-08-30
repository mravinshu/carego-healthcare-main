import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PopUpResponse extends StatelessWidget {
  const PopUpResponse({
    Key? key,
    required this.height,
    required this.width,
    required this.rive,
    required this.title,
    required this.message,
    required this.color,
  }) : super(key: key);

  final double height;
  final double width;
  final String rive;
  final String title;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: height / 3.014150943,
          left: width / 15.652173913,
          right: width / 15.652173913,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 20,
            child: Container(
              height: height / 3.491803279,
              width: width / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(""),
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          minimumSize: MaterialStateProperty.all(
                              Size(width / 3.157894737, height / 17.27027027)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(color),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(message)),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: height / 3.651428571,
          left: width / 2.517482517,
          right: width / 2.517482517,
          child: Container(
            height: height / 8.635135135,
            width: height / 8.635135135,
            child: RiveAnimation.asset(
              rive,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
