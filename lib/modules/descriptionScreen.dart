import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/product_detail_model.dart';

class DescriptionScreen extends StatelessWidget
{
  var photocontroller= PageController();
 ProductData  ? model;
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopCubitStates>(
        builder: (context,state)=>Scaffold(appBar: AppBar(),
        body: descriptionList(model),),
        listener: (context,state){});
  }
  Widget descriptionList(ProductData ? model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Center(
        child: Container(width: double.infinity,height: 150,
          child: PageView.builder(controller: photocontroller,
              itemCount:1,
              itemBuilder: (context,index)=>Image(
                image:
                NetworkImage(model!.images[0]),),
              scrollDirection: Axis.horizontal),
        ),
      ),
      // Center(
      //   child: SmoothPageIndicator(
      //     effect:ScaleEffect(activeDotColor: defaultColor,
      //         dotHeight: 10,dotWidth: 10,dotColor: Colors.grey,
      //         radius: 10
      //     ),
      //     controller:photocontroller , count: 3,
      //   ),
      // ),
      Text('${model!.name}',overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
        maxLines: 2,),
      SizedBox(height: 5.0,),
      Expanded(
        child: Text(model.description),
      )

    ],
  );
}
