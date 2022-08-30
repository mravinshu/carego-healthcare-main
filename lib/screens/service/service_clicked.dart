import 'package:carego_healthcare/screens/service/book_service_form.dart';
import 'package:carego_healthcare/screens/service/service_swipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/popup_response.dart';

class ServiceClicked extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int price;
  final int final_price;
  final int serviceId;
  const ServiceClicked(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.final_price,
      required this.serviceId})
      : super(key: key);

  @override
  State<ServiceClicked> createState() => _ServiceClickedState();
}

class _ServiceClickedState extends State<ServiceClicked> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Hero(
              tag: 'service_image',
              child: Padding(
                padding: EdgeInsets.only(bottom: height / 71),
                child: Image(
                  image: NetworkImage(
                    'https://raw.githubusercontent.com/Bonish123/carego-images/main/covid.png',
                  ),
                  height: height / 2.1,
                  width: width,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy < 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceSwiped(
                                serviceId: widget.serviceId,
                                serviceDescription: widget.description,
                                serviceFinalPrice: widget.final_price,
                                serviceImage: widget.image,
                                serviceName: widget.title,
                                servicePrice: widget.price,
                              )),
                    );
                  }
                },
                child: Hero(
                  tag: 'service_card',
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width / 12.0, right: width / 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: height / 35.5, bottom: height / 31.95),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/SVG/Line 3.svg',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: height / 33.631578947,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: width / 12,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 31.95),
                            child: Text(
                              widget.description.substring(0, 50) + "......",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: height / 49.153846154),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Final Price",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "₹" + widget.price.toString(),
                                            style: TextStyle(
                                                fontSize: height / 30.428571429,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Offer Price",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "₹" + widget.final_price.toString(),
                                      style: TextStyle(
                                          fontSize: height / 30.428571429,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 40),
                            child: Center(
                              child: SizedBox(
                                width: width / 2,
                                height: height / 16,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      // showDialog<void>(
                                      //   context: context,
                                      //   barrierDismissible: true,
                                      //   builder: (BuildContext context) {
                                      //     return PopUpResponse(
                                      //       height: height,
                                      //       width: width,
                                      //       message: 'Try Again',
                                      //       rive: 'assets/Rive/error_icon.riv',
                                      //       title: 'Error',
                                      //       color:
                                      //           Color.fromARGB(255, 255, 0, 0),
                                      //     );
                                      //   },
                                      // );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookService(
                                            final_price: widget.final_price,
                                            serviceId: widget.serviceId,
                                            serviceName: widget.title,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Book service",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: height / 37.5,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
