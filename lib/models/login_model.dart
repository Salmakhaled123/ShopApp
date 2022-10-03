class ShopLoginModel
{
 bool ?status;
 String? message;
late  UserData  data;
ShopLoginModel.fromJson(Map<String,dynamic>json)
{
  status=json['status'];
  message=json['message'];
  data= UserData.fromJson(json['data']) ;

}
}
class UserData
{
 int? id;
late  String name;
 late String  email;
 late String  phone;
String ? image;
int ? points;
int ? credit;
late String  token;
//named constructor
  UserData.fromJson(Map<String,dynamic>json)
  {
   // id=json['id'];
    name=json['name'];
   // points=json['points'];
    phone=json['phone'];
    email=json['email'];
   // credit=json['credit'];
    token=json['token'];
   // image=json['image'];

  }

}
