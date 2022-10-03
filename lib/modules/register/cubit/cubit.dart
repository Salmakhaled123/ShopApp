import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import '../../../dio/diohelper.dart';
import '../../../models/login_model.dart';
import '../../../network/end_points.dart';
class RegisterCubit extends Cubit<ShopRegisterStates>
{
  RegisterCubit():super(ShopRegisterInitialState());
  ShopLoginModel ?model;
  static RegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    Diohelper.postData(
        url: register,
        data: {
          'name':name,
          'email':email,
        'password':password,
        'phone': phone
        }).then((value)
    {
      model=  ShopLoginModel.fromJson(value.data);
      // print(model.status);
      // print(model.message);

   emit(ShopRegisterSuccessState(model!));
    }).catchError((error)
    {
      print(error.toString());
 emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool IsPassword=true;
  void ChangePasswordVisibility()
  {
    IsPassword=!IsPassword;
    suffix=IsPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }

}