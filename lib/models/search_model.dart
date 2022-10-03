class SearchModel {
  bool? status;
   Data ? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =   Data.fromJson(json['data']) ;
  }
}
class Data {
  int ?currentPage;
  List<Product> data=[];
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      json['data'].forEach((v) {
        data.add( Product.fromJson(v));
      });
    }

  }


}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
 late String   image;
 late String  name;
  String ? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
