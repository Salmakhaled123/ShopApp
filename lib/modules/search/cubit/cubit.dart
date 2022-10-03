import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio/diohelper.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
 static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel ? model;
 void search({String ? text})
 {
   emit(SearchLoadingState());
   Diohelper.postData(url: Search,
       data: {
     'text':text,

   }).then((value)
   {
     model=SearchModel.fromJson(value.data);
     emit(SearchSuccessState());
   }).catchError((error)
   {
     print(error.toString());
     emit(SearchErrorState());
   });
 }

}