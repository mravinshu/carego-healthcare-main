class CategoryModel {
  late String _title;
  late int _id;

  CategoryModel(var userRes) {
    _title = userRes['category_name'];
    _id = userRes['category_id'];
  }

  String get title => _title;
  int get id => _id;
}
