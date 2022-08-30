import 'dart:convert';
import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/models/CategoryModel.dart';
import 'package:carego_healthcare/models/ServiceModel.dart';
import 'package:carego_healthcare/screens/service/book_service_form.dart';
import 'package:carego_healthcare/widgets/bottom_nav_bar.dart';
import 'package:carego_healthcare/widgets/serviceCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../requests/auth_provider.dart';
import '../../widgets/appbar_new.dart';
import '../../widgets/drawer_user.dart';

class Services extends StatefulWidget {
  final CategoryModel categoryInfo;
  final List<CategoryModel> postJson;
  Services({
    Key? key,
    required this.categoryInfo,
    required this.postJson,
  }) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List<CategoryModel> postJson = [];
  String loading = "";
  List<ServiceModel> serviceJson = [];
  String loadingService = "";

  void getService(value) async {
    // final Response response = await AuthProvider().getService(value);
    // setState(() {
    //   serviceJson =
    //       json.decode(response.body)['response'].map<ServiceModel>((json) {
    //     return ServiceModel(json);
    //   }).toList();
    //   loadingService = "done";
    // });
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(value.toString()) == "Not Loaded") {
      final Response response = await AuthProvider().getService(value);
      setState(() {
        serviceJson =
            json.decode(response.body)['response'].map<ServiceModel>((json) {
          return ServiceModel(json);
        }).toList();
        loadingService = "done";
      });
      await prefs.setString(value.toString(), response.body);
    } else {
      final String? response = prefs.getString(value.toString());
      setState(() {
        serviceJson = json
            .decode(response!)['response']
            .map<ServiceModel>((json) => ServiceModel(json))
            .toList();
        loadingService = "done";
      });
    }
  }

  String value = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      postJson = widget.postJson;
      value = widget.categoryInfo.id.toString();
    });
    getService(value);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return SafeArea(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Container(
                //   decoration: BoxDecoration(
                //       color: drawer_icon_back,
                //       borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: value,
                    decoration: InputDecoration(),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    onChanged: (value) {
                      setState(() {
                        loadingService = "";
                        value = value;
                      });
                      getService(value);
                    },
                    hint: const Text("  Select Category"),
                    items: [
                      for (int i = 0; i < postJson.length; i++)
                        DropdownMenuItem<String>(
                          value: postJson[i].id.toString(),
                          child: Text(postJson[i].title),
                        ),
                    ],
                  ),
                  // child: DropdownButtonFormField(
                  //   decoration: const InputDecoration(),
                  //   value: value,
                  //   hint: const Text("  Select Category"),
                  //   items: [
                  //     for (int i = 0; i < postJson.length; i++)
                  //       DropdownMenuItem<String>(
                  //         value: postJson[i].id.toString(),
                  //         child: Text(postJson[i].title),
                  //       ),
                  //   ],
                  //   onChanged: (value) {
                  //     setState(() {
                  //       loadingService = "";
                  //       value = value;
                  //     });
                  //     getService(value);
                  //   },
                  // ),
                ),
              ),
              // ),
            ),
            loadingService == "done"
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        for (int i = 0; i < serviceJson.length; i++)
                          ServiceListCard(
                            title: serviceJson[i].title,
                            description: serviceJson[i].description,
                            final_price: serviceJson[i].final_price,
                            image: serviceJson[i].image,
                            price: serviceJson[i].price,
                            serviceId: serviceJson[i].id,
                          )
                      ],
                    ),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: drawer_icon_front,
                    ),
                  )
          ],
        ),
        bottomNavigationBar: BottomNavBarNew(),
      ),
    );
  }
}
