class FavoritesModel {
  bool? status;
 late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =   Data.fromJson(json['data']) ;
  }
}
class Data {
  int ?currentPage;
  List<FavData> data=[];
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String ?lastPageUrl;
 // Null ?nextPageUrl;
  String ? path;
  int ? perPage;
 // Null ? prevPageUrl;
  int ? to;
  int ? total;
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      json['data'].forEach((v) {
        data.add( FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
   // nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
  //  prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class FavData {
 late int id;
  Product ? product;
  FavData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    product =
    Product.fromJson(json['product']) ;
  }


}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ?  image;
  String ? name;
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
