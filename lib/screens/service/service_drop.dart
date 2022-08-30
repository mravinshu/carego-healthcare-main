import 'dart:convert';
import 'package:carego_healthcare/models/CategoryModel.dart';
import 'package:carego_healthcare/models/ServiceModel.dart';
import 'package:carego_healthcare/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Theme/color.dart';
import '../../requests/auth_provider.dart';
import '../../widgets/appbar_new.dart';
import '../../widgets/drawer_user.dart';
import '../../widgets/serviceCard.dart';

class ServiceDropDown extends StatefulWidget {
  const ServiceDropDown({Key? key}) : super(key: key);

  @override
  State<ServiceDropDown> createState() => _ServiceDropDownState();
}

class _ServiceDropDownState extends State<ServiceDropDown> {
  List<CategoryModel> postJson = [];
  List<ServiceModel> serviceJson = [];
  String loading = "";
  String loadingService = "";
  String dropdownSelected = "";
  String? value;
  String? selectedService;

  void getService(value) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(value.toString()) == "Not Loaded") {
      final Response response = await AuthProvider().getService(value);
      setState(() {
        serviceJson =
            json.decode(response.body)['response'].map<ServiceModel>((json) {
          return ServiceModel(json);
        }).toList();
        loadingService = "done";
        dropdownSelected = "";
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
        dropdownSelected = "";
      });
    }
  }

  void getCategoryDash() async {
    final prefs = await SharedPreferences.getInstance();
    final String? response = prefs.getString('category_response');
    setState(() {
      postJson = json
          .decode(response!)['response']
          .map<CategoryModel>((json) => CategoryModel(json))
          .toList();
      loading = "done";
      loadingService = "";
      dropdownSelected = "true";
      value = postJson[0].id.toString();
    });
    getService(value);
    // final Response response = await AuthProvider().getCategory();

    // setState(() {
    //   postJson =
    //       json.decode(response.body)['response'].map<CategoryModel>((json) {
    //     return CategoryModel(json);
    //   }).toList();
    //   loading = "done";
    // });
  }

  @override
  void initState() {
    super.initState();
    getCategoryDash();
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
            loading == "done"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          value: value,
                          decoration: InputDecoration(),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          onChanged: (value) {
                            setState(() {
                              loadingService = "";
                              dropdownSelected = "true";
                              value = value;
                            });
                            getService(value);
                          },
                          hint: const Text("  Select Category"),
                          items: [
                            for (int i = 0; i < postJson.length; i++)
                              DropdownMenuItem<String>(
                                value: postJson[i].id.toString(),
                                child: Text("   " + postJson[i].title),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: drawer_icon_front,
                    ),
                  ),
            if (dropdownSelected == "" && loadingService == "done")
              Expanded(
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
              )),
            if (dropdownSelected == "true") CircularProgressIndicator()
          ],
        ),
        bottomNavigationBar: BottomNavBarNew(),
      ),
    );
  }
}
