import 'dart:convert';

import 'package:carego_healthcare/widgets/curved_appbar.dart';
import 'package:carego_healthcare/widgets/decorated_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../requests/auth_provider.dart';
import '../../widgets/decorated_text_feild_suffix.dart';
import '../../widgets/popup_response.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword(
      {Key? key,
      required this.userName,
      required this.userEmail,
      required this.userPhone,
      required this.userId})
      : super(key: key);
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userId;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passController = TextEditingController();
  bool isSaving = false;
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    double width = data.size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CurvedAppBar(
              titleHeading: "Change Password",
              height: height,
              width: width,
            ),
            Flexible(
                child: SingleChildScrollView(
              child: Column(children: [
                SvgPicture.asset(
                  'assets/SVG/pass.svg',
                  height: height / 2.2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 18.947368421,
                      right: width / 18.947368421,
                      top: height / 22.821428571),
                  child: DecoratedTextFeildSuffix(
                      obsecureText: true,
                      iconUsed: Icons.lock_outline,
                      labelUsed: 'New Password',
                      controller: passController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 18.947368421,
                      right: width / 18.947368421,
                      top: height / 22.821428571),
                  child: DecoratedTextFeildSuffix(
                      obsecureText: true,
                      iconUsed: Icons.lock_outline,
                      labelUsed: 'Confirm Password',
                      controller: confirmPassController),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height / 22.034482759),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSaving = true;
                      });
                      final response = await AuthProvider().editUser(
                          widget.userId,
                          json.encode({
                            "fullname": widget.userName,
                            "email": widget.userEmail,
                            "contact": widget.userPhone,
                            "password": passController.text
                          }));
                      if (response.statusCode == 200) {
                        Navigator.pop(context);
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
                        _pref.setString("user_name", widget.userName);
                        _pref.setString("user_email", widget.userEmail);
                        _pref.setString("user_phone", widget.userPhone);
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
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            color: Colors.blue,
                            child: SizedBox(
                              height: height / 14.285714286,
                              width: width / 1.1,
                              child: Center(
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                      fontSize: width / 22.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ]),
            ))
          ],
        ),
      ),
    );
  }
}
