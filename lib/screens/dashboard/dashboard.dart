import 'dart:convert';
import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/models/CategoryModel.dart';
import 'package:carego_healthcare/requests/auth_provider.dart';
import 'package:carego_healthcare/widgets/category_card.dart';
import 'package:carego_healthcare/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/appbar_new.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/drawer_user.dart';
import '../../widgets/heading_name.dart';

class Dashboard extends StatefulWidget {
  final bool alreadyBuild;
  Dashboard({Key? key, required this.alreadyBuild}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<CategoryModel> postJson = [];

  String loading = "";

  void getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    final Response response = await AuthProvider().profile(userId);
    String name = json.decode(response.body)['response']['name'];
    String email = json.decode(response.body)['response']['email'];
    String phone = json.decode(response.body)['response']['contact'];
    setState(() {
      prefs.setString('user_name', name);
      prefs.setString('user_email', email);
      prefs.setString('user_phone', phone);
    });
  }

  void getCategoryDash() async {
    final prefs = await SharedPreferences.getInstance();
    if (!widget.alreadyBuild) {
      getUserProfile();
      final Response response = await AuthProvider().getCategory();
      setState(() {
        postJson =
            json.decode(response.body)['response'].map<CategoryModel>((json) {
          return CategoryModel(json);
        }).toList();
        loading = "done";
      });
      await prefs.setString('category_response', response.body);
      for (var i = 0; i < postJson.length; i++) {
        await prefs.setString(postJson[i].id.toString(), "Not Loaded");
      }
    } else {
      final String? response = prefs.getString('category_response');
      setState(() {
        postJson = json
            .decode(response!)['response']
            .map<CategoryModel>((json) => CategoryModel(json))
            .toList();
        loading = "done";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryDash();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(100, 60, Colors.blue),
      ChartData(100, 60, Colors.blueAccent),
      ChartData(100, 100, Colors.blue),
    ];
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return loading == "done"
        ? SafeArea(
            child: Scaffold(
              drawer: Drawer_User(
                height: height,
              ),
              backgroundColor: scaffold_back,
              body: Column(
                children: [
                  AppBarNew(height: height),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     decoration: const BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.all(Radius.circular(10))),
                        //     child: TextField(
                        //       decoration: InputDecoration(
                        //           fillColor: Colors.white,
                        //           hintText: "Search Location",
                        //           prefixIcon: Icon(
                        //             Icons.pin_drop,
                        //             color: drawer_icon_front,
                        //           ),
                        //           border: InputBorder.none),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8, bottom: 8),
                          child: SizedBox(
                            height: height / 4.34,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int i = 0; i < 6; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8, bottom: 8),
                                    child: ServiceCard(
                                      height: height,
                                      width: width,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8, bottom: 8),
                          child: HeadingName(
                            width: width,
                            name: "Category",
                            isSearch: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8, bottom: 8),
                          child: SizedBox(
                            height: height / 4.34,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                loading == "done"
                                    ? SizedBox(
                                        height: height / 3,
                                        child: ListView(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            for (int i = 0; i < 6; i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0,
                                                    top: 8,
                                                    bottom: 8),
                                                child: CategoryCard(
                                                  title: postJson[i].title,
                                                  height: height,
                                                  width: width,
                                                  categoryInfo: postJson[i],
                                                  postJson: postJson,
                                                ),
                                              )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: drawer_icon_front,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: height / 5, width: height / 5, child: Text("")
                          // SfCircularChart(
                          //   series: <CircularSeries>[
                          //     RadialBarSeries<ChartData, double>(
                          //       useSeriesColor: true,
                          //       trackColor: Colors.blue,
                          //       trackOpacity: 0.3,
                          //       gap: '10%',
                          //       dataSource: chartData,
                          //       xValueMapper: (ChartData data, _) => data.x,
                          //       yValueMapper: (ChartData data, _) => data.y,
                          //       cornerStyle: CornerStyle.bothCurve,
                          //     )
                          //   ],
                          // ),
                          ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: const BottomNavBarNew(),
            ),
          )
        : Scaffold(
            backgroundColor: scaffold_back,
            body: Center(
              child: CircularProgressIndicator(
                color: drawer_icon_front,
              ),
            ),
          );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final double x;
  final double y;
  final Color color;
}
