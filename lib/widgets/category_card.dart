import 'package:carego_healthcare/Theme/color.dart';
import 'package:carego_healthcare/models/CategoryModel.dart';
import 'package:carego_healthcare/screens/service/service.dart';
import 'package:carego_healthcare/screens/service/service_clicked.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final List<CategoryModel> postJson;
  final CategoryModel categoryInfo;
  const CategoryCard(
      {Key? key,
      required this.height,
      required this.width,
      required this.categoryInfo,
      required this.title,
      required this.postJson})
      : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Services(
                    categoryInfo: widget.categoryInfo,
                    postJson: widget.postJson,
                  )),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: widget.height / 5,
          width: widget.width / 2.4,
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(widget.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
