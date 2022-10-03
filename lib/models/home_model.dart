class HomeModel
{
  bool ? status;
  HomeDataModel ? data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }

}
class HomeDataModel
{
  String ? ad;
  List<BannersModel>banners=[];
  List<ProductsModel>products=[];
  HomeDataModel.fromJson(Map<String,dynamic>json)
  {

  json['banners'].forEach((element)
  {
    banners.add(BannersModel.fromJson(element));
  });
   json['products'].forEach((element)
   {
     products.add(ProductsModel.fromJson(element));
   });
  }

}
class BannersModel
{
  int ? id;
  String ? image;
  BannersModel.fromJson(Map<String,dynamic>json)
  {
id=json['id'];
image=json['image'];
  }
}
class ProductsModel
{
late  int  productId;
 dynamic  price;
  dynamic  oldPrice;
  dynamic  discount;
late String  name;
  String ?image;
late  bool  in_favorites;
  bool ? in_cart;
//named constructor
ProductsModel.fromJson(Map<String,dynamic>json)
{
  name=json['name'];
productId=json['id'];
price=json['price'];
oldPrice=json['old_price'];
image=json['image'];
discount=json['discount'];
in_favorites=json['in_favorites'];
}


}