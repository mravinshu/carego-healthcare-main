import 'dart:convert';

import 'package:carego_healthcare/requests/auth_provider.dart';
import 'package:carego_healthcare/screens/service/payment_gateway.dart';
import 'package:carego_healthcare/widgets/curved_appbar.dart';
import 'package:carego_healthcare/widgets/decorated_text_feild.dart';
import 'package:carego_healthcare/widgets/drawer_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/popup_response.dart';

String? timeValue = null;

class BookService extends StatefulWidget {
  BookService(
      {Key? key,
      required this.serviceId,
      required this.final_price,
      required this.serviceName})
      : super(key: key);

  final int serviceId;
  final int final_price;
  final String serviceName;

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  final nameController = TextEditingController();

  final numberController = TextEditingController();

  final emailController = TextEditingController();

  final cityController = TextEditingController();

  final landmarkController = TextEditingController();

  bool isSaving = false;

  String userName = "";
  String userEmail = "";
  String userId = '';
  String userPhone = "";

  getDetails() async {
    final _pref = await SharedPreferences.getInstance();
    setState(() {
      userName = _pref.getString("user_name")!;
      userEmail = _pref.getString("user_email")!;
      userId = _pref.getString("user_id")!;
      userPhone = _pref.getString("user_phone")!;
    });
    nameController.text = _pref.getString('user_name')!;
    emailController.text = _pref.getString('user_email')!;
    numberController.text = _pref.getString('user_phone')!;
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return SafeArea(
      child: Scaffold(
        // body: Column(
        //   children: [
        //     AppBarNew(height: height),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(""),
        //         Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 color: drawer_icon_back,
        //                 borderRadius: BorderRadius.all(Radius.circular(10))),
        //             width: height / 12,
        //             height: height / 12,
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   icon: Icon(
        //                     Icons.add,
        //                     color: drawer_icon_front,
        //                   ),
        //                   onPressed: () {},
        //                 ),
        //                 Text(
        //                   "Book",
        //                   style: TextStyle(color: drawer_icon_front),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // bottomNavigationBar: BottomNavBarNew(),
        body: Column(children: [
          CurvedAppBar(
              height: height, width: width, titleHeading: "Service Details"),
          Flexible(
            flex: 4,
            child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 18.257142857,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: DecoratedTextFeild(
                        enabled: false,
                        controller: nameController,
                        iconUsed: Icons.person_outline,
                        labelUsed: "Full Name"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 21.3,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: DecoratedTextFeild(
                        enabled: false,
                        controller: numberController,
                        iconUsed: Icons.phone_outlined,
                        labelUsed: "Phone Number"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 21.3,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: DecoratedTextFeild(
                        enabled: false,
                        controller: emailController,
                        iconUsed: Icons.mail_outline,
                        labelUsed: "Email"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 21.3,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: DecoratedTextFeild(
                        controller: cityController,
                        iconUsed: Icons.location_on_outlined,
                        labelUsed: "City"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 21.3,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: DecoratedTextFeild(
                        controller: landmarkController,
                        iconUsed: Icons.push_pin_outlined,
                        labelUsed: "Landmark"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 21.3,
                        bottom: 20,
                        left: width / 18.947368421,
                        right: width / 18.947368421),
                    child: const DecoratedDropDown(
                      icon: Icons.timer_outlined,
                      hint: "Service Duration",
                      items: ["Short Visit", "6 Hours", "12 Hours", "24 * 7"],
                      values: ["Short Visit", "6hr", "12hr", "24*7"],
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                    right: width / 3.302752294,
                    bottom: height / 30.428571429,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height / 71,
                              horizontal: width / 25.714285714),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: width / 22.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  right: width / 22.5,
                  bottom: height / 30.428571429,
                  child: GestureDetector(
                    onTap: () async {
                      print(timeValue == null &&
                          cityController.text == "" &&
                          landmarkController.text == "");
                      if (cityController.text == "" ||
                          landmarkController.text == "" ||
                          timeValue == null) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill all the fields',
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          isSaving = true;
                        });
                        final _pref = await SharedPreferences.getInstance();
                        String? userId = _pref.getString("user_id");
                        final Response response =
                            await AuthProvider().bookingService(
                          userId.toString(),
                          widget.serviceId,
                          json.encode({
                            "city": cityController.text,
                            "landmark": landmarkController.text,
                            "availability_time": timeValue
                          }),
                        );
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentGateway(
                                service_name: widget.serviceName,
                                fina_price: widget.final_price,
                                service_id: widget.serviceId,
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            isSaving = false;
                          });
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return PopUpResponse(
                                height: ScreenUtil.defaultSize.height,
                                width: ScreenUtil.defaultSize.width,
                                message: 'Try Again',
                                rive: 'assets/Rive/error_icon.riv',
                                title: 'Error',
                                color: Color.fromARGB(255, 255, 0, 0),
                              );
                            },
                          );
                        }
                      }
                    },
                    child: isSaving
                        ? const Center(child: CircularProgressIndicator())
                        : Card(
                            elevation: 10,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height / 71,
                                  horizontal: width / 16.363636364),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: width / 22.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class DecoratedDropDown extends StatelessWidget {
  const DecoratedDropDown({
    Key? key,
    required this.hint,
    required this.icon,
    required this.items,
    required this.values,
  }) : super(key: key);

  final String hint;
  final IconData icon;
  final List<String> items;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.location_on_outlined),
        ),
        hint: Text(hint),
        items: [
          for (int i = 0; i < items.length; i++)
            DropdownMenuItem(
              value: values[i],
              child: Text(items[i]),
            )
        ],
        onChanged: (value) {
          timeValue = value.toString();
        });
  }
}
