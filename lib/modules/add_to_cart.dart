import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/get_carts.dart';
import 'package:shop_app/styles/colors/colors.dart';
class AddToCart extends StatelessWidget
{

  Widget buildCartItem(ProductCart ? model)
  {
    return BlocConsumer<ShopCubit,ShopCubitStates>(builder:(context,state){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: NetworkImage('${model!.image}'
                    ,
                  ),
                  width: 80,
                  height: 60,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Text(
                    '${model.name}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('${model.price} EGB',style: TextStyle(fontSize: 24.0,
            fontWeight: FontWeight.bold,color: defaultColor),)
          ],
        ),
      );
    } ,
      listener:(context,state){} ,

    );
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopCubitStates>(
      listener: (context,state) {},
      builder: (context,state)
      {

        return Scaffold(
            appBar: AppBar(
                title: Text(
                  'Shop Cart',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: defaultColor),
          body: ConditionalBuilder(builder:(context) =>ListView.separated(
              itemBuilder:(context,index)=> buildCartItem
                (
                  ShopCubit.get(context).cart?.data?.cartItems[index].product
              ),
              separatorBuilder: (context,index)=>Divider(),
              itemCount: ShopCubit.get(context).cart!.data!.cartItems.length),
            fallback:(context)=>
    Center(child: Image(image: NetworkImage('https://th.bing.com/th/id/OIP.rRcehUCmVVwg8xRCqiEWXAAAAA?pid=ImgDet&rs=1'))) ,
            condition:ShopCubit.get(context).cart?.data?.cartItems.length
            !=0 ,
          ),

      );
      },

    );

  }
 

}
