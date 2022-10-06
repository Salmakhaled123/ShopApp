class ProductDetails
{
  bool ? status;
  ProductData ? data;
  ProductDetails.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=json['data'] !=null?ProductData.fromJson(json['data']):null;
  }
}
class ProductData
{
  int ? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String ?image;
  String? name;
  String? description;
 List<String>images=[];
  ProductData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    images = List.castFrom<dynamic,String>(json['images']);



  }


}
