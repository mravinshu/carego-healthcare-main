import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/screens/service/service_clicked.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final double height;
  final double width;
  const ServiceCard({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ServiceClicked()),
        // );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: height / 5,
          width: width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.water_drop,
                    color: service_icon,
                    size: 50,
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Doctor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
