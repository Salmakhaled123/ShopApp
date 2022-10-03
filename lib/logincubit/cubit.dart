import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio/diohelper.dart';
import 'package:shop_app/logincubit/states.dart';
import 'package:shop_app/network/end_points.dart';

import '../models/login_model.dart';


class AppCubit extends Cubit<ShopLoginStates>
{
  AppCubit():super(ShopLoginInitialState());
  late ShopLoginModel model;
  static AppCubit get(context)=>BlocProvider.of(context);
  void userLogin({required String email,required String password})
  {
    emit(ShopLoginLoadingState());
    Diohelper.postData(
        url: login,
        data: {'email':email,
        'password':password}).then((value)
    {

      model=  ShopLoginModel.fromJson(value.data);
      // print(model.status);
      // print(model.message);

          emit(ShopLoginSuccessState(model));
    }).catchError((error)
    {
 emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool IsPassword=true;
  void ChangePasswordVisibility()
  {
    IsPassword=!IsPassword;
    suffix=IsPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopChangeVisibilityState());
  }

}