class ChangeFavModel
{
 late bool  status;
 late String message;
  ChangeFavModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}
