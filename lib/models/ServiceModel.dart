class ServiceModel {
  late String _title;
  late int _id;
  late String _description;
  late String _image;
  late int _price;
  late int _final_price;

  ServiceModel(var userRes) {
    _title = userRes['service_name'];
    _id = userRes['service_id'];
    _description = userRes['service_description'];
    _image = userRes['service_image'];
    _price = userRes['service_cost'];
    _final_price = userRes['offer_cost'];
  }

  String get title => _title;
  int get id => _id;
  String get description => _description;
  String get image => _image;
  int get price => _price;
  int get final_price => _final_price;
}
