import 'package:carego_healthcare/screens/service/service_clicked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceListCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int price;
  final int final_price;
  final int serviceId;
  const ServiceListCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.final_price,
      required this.serviceId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceClicked(
                description: description,
                final_price: final_price,
                image: image,
                price: price,
                title: title,
                serviceId: serviceId,
              ),
            ),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: image.contains('')
                      ? Image(
                          image: NetworkImage(
                            'https://raw.githubusercontent.com/Bonish123/carego-images/main/covid.png',
                          ),
                          height: height / 10.285714286,
                          width: height / 10.285714286,
                        )
                      : SvgPicture.asset(
                          image,
                          height: 50,
                          width: 50,
                        )),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
