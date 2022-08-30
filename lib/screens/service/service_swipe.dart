import 'package:carego_healthcare/widgets/popup_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rive/rive.dart';

import 'book_service_form.dart';

class ServiceSwiped extends StatefulWidget {
  final String serviceName;
  final String serviceImage;
  final int servicePrice;
  final String serviceDescription;
  final int serviceFinalPrice;
  final int serviceId;
  const ServiceSwiped(
      {Key? key,
      required this.serviceName,
      required this.serviceImage,
      required this.servicePrice,
      required this.serviceId,
      required this.serviceDescription,
      required this.serviceFinalPrice})
      : super(key: key);

  @override
  State<ServiceSwiped> createState() => _ServiceSwipedState();
}

class _ServiceSwipedState extends State<ServiceSwiped> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: [
          IconButton(
            iconSize: 27,
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            child: Hero(
              tag: 'service_image',
              child: Image(
                image: NetworkImage(
                    'https://raw.githubusercontent.com/Bonish123/carego-images/main/covid.png'),
                height: height / 4.9921875,
              ),
            ),
          ),
          Expanded(
            child: Hero(
              tag: 'service_card',
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width / 12.0, right: width / 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onPanUpdate: (details) {
                          if (details.delta.dy > 0) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          color: Colors.blue,
                          height: height / 14.522727273,
                          width: width,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/SVG/Line 3.svg',
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.serviceName,
                              style: TextStyle(
                                fontSize: height / 33.631578947,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹" + widget.servicePrice.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: height / 37.588235294,
                                    color: Colors.white),
                              ),
                              Text(
                                "₹" + widget.serviceFinalPrice.toString(),
                                style: TextStyle(
                                    fontSize: height / 30.428571429,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 21.3),
                        child: Text("Description",
                            style: TextStyle(
                              fontSize: height / 33.631578947,
                              color: Colors.white,
                            )),
                      ),
                      Center(
                        child: Container(
                          width: width / 1.2,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${widget.serviceDescription}\n",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: height / 15.975,
                          child: Center(
                            // child: RatingBar(
                            //   tapOnlyMode: true,
                            //   initialRating: 4,
                            //   minRating: 1,
                            //   direction: Axis.vertical,
                            //   allowHalfRating: false,
                            //   itemCount: 5,
                            //   itemPadding:
                            //       EdgeInsets.symmetric(horizontal: 4.0),
                            //   onRatingUpdate: (rating) {},
                            //   ratingWidget: RatingWidget(
                            //       full: Icon(
                            //         Icons.star,
                            //         color: Colors.amber,
                            //       ),
                            //       half: Icon(
                            //         Icons.star_half,
                            //         color: Colors.amber,
                            //       ),
                            //       empty: Icon(
                            //         Icons.star_border,
                            //         color: Colors.amber,
                            //       )),
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookService(
                                        final_price: widget.serviceFinalPrice,
                                        serviceId: widget.serviceId,
                                        serviceName: widget.serviceName,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
