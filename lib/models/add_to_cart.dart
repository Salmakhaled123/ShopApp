class CartModel
{
  bool ? status;
  String ?message;
  DataCart ? data;
  CartModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null ?DataCart.fromJson(json['data']):null ;

  }
}
class DataCart
{
//int ? id;
//int? quantity;
ProductCart ?product;
DataCart.fromJson(Map<String,dynamic> json)
{
 // id=json['id'];
 // quantity=json['quantity'];
  product=json['product']!=null ? ProductCart.fromJson(json['product']):null;
}
}
class ProductCart
{
 int ? productId;
 //dynamic  price;
 String ? image;
 String ?name;
 ProductCart.fromJson(Map<String,dynamic>json)
 {
 productId=json['id'];
   image=json['image'];
   name=json['name'];
 }
}