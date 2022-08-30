import 'dart:convert';

import 'package:carego_healthcare/requests/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/curved_appbar.dart';
import '../../widgets/decorated_text_feild.dart';
import '../../widgets/popup_response.dart';
import 'chage_password.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({Key? key}) : super(key: key);

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String userName = "";
  String userEmail = "";
  String userId = '';
  String userPhone = "";
  bool isSaving = false;
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
    phoneController.text = _pref.getString('user_phone')!;
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
        body: Column(
          children: [
            CurvedAppBar(
              height: height,
              width: width,
              titleHeading: "Edit Details",
            ),
            Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  child: Container(
                    height: height / 1.5,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 10.142857143,
                            left: width / 18.947368421,
                            right: width / 18.947368421),
                        child: DecoratedTextFeild(
                          controller: nameController,
                          iconUsed: Icons.person_outline,
                          labelUsed: "Name",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 17,
                            left: width / 18.947368421,
                            right: width / 18.947368421),
                        child: DecoratedTextFeild(
                          controller: emailController,
                          iconUsed: Icons.mail_outline,
                          labelUsed: "Email",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 17,
                            left: width / 18.947368421,
                            right: width / 18.947368421),
                        child: DecoratedTextFeild(
                          controller: phoneController,
                          iconUsed: Icons.phone_outlined,
                          labelUsed: "Contact",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width / 18.947368421,
                            right: width / 18.947368421,
                            top: height / 30),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(
                                      userName: nameController.text,
                                      userEmail: emailController.text,
                                      userPhone: phoneController.text,
                                      userId: userId,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Change Password?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                )),
            Expanded(
              flex: 1,
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
                          shape: RoundedRectangleBorder(
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
                        setState(() {
                          isSaving = true;
                        });
                        final response = await AuthProvider().editUser(
                            userId,
                            json.encode({
                              "fullname": nameController.text,
                              "email": emailController.text,
                              "contact": phoneController.text,
                            }));
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return PopUpResponse(
                                height: ScreenUtil.defaultSize.height,
                                width: ScreenUtil.defaultSize.width,
                                message: 'Ok',
                                rive: 'assets/Rive/sucess.riv',
                                title: 'Success',
                                color: Color.fromRGBO(62, 217, 111, 1),
                              );
                            },
                          );
                          final _pref = await SharedPreferences.getInstance();
                          _pref.setString("user_name", nameController.text);
                          _pref.setString("user_email", emailController.text);
                        } else {
                          setState(() {
                            isSaving = false;
                          });
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not update details'),
                            ),
                          );
                        }
                      },
                      child: isSaving
                          ? CircularProgressIndicator()
                          : Card(
                              shape: RoundedRectangleBorder(
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
          ],
        ),
      ),
    );
  }
}
