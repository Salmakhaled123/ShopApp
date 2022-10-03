import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget
{
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopCubitStates>(
      builder: (context,state){
        return ListView.separated(
            itemBuilder:(context,index)=> buildCatItem(ShopCubit.get(context).categoryModel!.data.data[index]),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Divider(),
            ),
            itemCount: ShopCubit.get(context).categoryModel!.data.data.length);
      },
      listener: (context,state){},

    );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children:
    [
      Image(image: NetworkImage('${model.image}'),
        width: 80.0,
        height:80.0,
        fit: BoxFit.cover,),
      SizedBox(width: 20,),
      Text('${model.name}',
        style: TextStyle(fontSize: 18.0,
            fontWeight: FontWeight.bold),),
      Spacer(),
      Icon(Icons.arrow_forward_ios),

    ],),
  );
}
