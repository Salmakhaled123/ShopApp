import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/product_detail_model.dart';
import 'package:shop_app/modules/descriptionScreen.dart';
import 'package:shop_app/network/components/components.dart';
import 'package:shop_app/styles/colors/colors.dart';

class ProductsScreen extends StatelessWidget
{


 ProductsScreen({Key? key}) : super(key: key);
 Widget productsBuilder(HomeModel ? model,CategoriesModel ? CategoryModel,context,) {

   return SingleChildScrollView(
     physics: const BouncingScrollPhysics(),
     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         CarouselSlider(
             items: model!.data!.banners
                 .map((e) => Image(
               image: NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             ))
                 .toList(),
             options: CarouselOptions(
               height: 150,
               initialPage: 0,
               enableInfiniteScroll: true,
               reverse: false,
               autoPlay: true,
               autoPlayInterval: Duration(seconds: 3),
               autoPlayAnimationDuration: Duration(seconds: 1),
               autoPlayCurve: Curves.fastOutSlowIn,
               scrollDirection: Axis.horizontal,
               viewportFraction: 1.0,
             )),
         const SizedBox(
           height: 10.0,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('Categories',
                 style: TextStyle(fontSize: 22,
                     fontWeight: FontWeight.w800),),
               const  SizedBox(height: 10.0,),
               Container(height: 100,
                 child: ListView.separated(scrollDirection: Axis.horizontal,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context,index)=>buildCategoryItem(CategoryModel.data.data[index],),
                     separatorBuilder: (context,index)=>SizedBox(width: 10,),
                     itemCount: CategoryModel!.data.data.length),
               ),
               SizedBox(height:5.0,),
               Text('New Products',
                 style: TextStyle(fontSize: 22,
                     fontWeight: FontWeight.w800),),
             ],
           ),
         ),
         Container(
           color: Colors.grey[300],
           child: GridView.count(
             crossAxisCount: 2,
             mainAxisSpacing: 1.0,
             crossAxisSpacing: 1.0,
             childAspectRatio: 1 / 1.79,
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             children: List.generate(model.data!.products.length,
                     (index) => buildGridProduct(model.data!.products[index],context,)),
           ),
         ),
       ],
     ),
   );}

 Widget buildCategoryItem(DataModel model)=> Stack(alignment: AlignmentDirectional.bottomCenter,
   children:
   [
     Image(image: NetworkImage('${model.image}'),
       width: 100,
       height: 100,
       fit: BoxFit.cover,),
     Container(color: Colors.black.withOpacity(0.8),width: 100,
       child: Text('${model.name}',textAlign: TextAlign.center,
         style: TextStyle(color: Colors.white,),),
     )

   ],);
  @override
  Widget build(BuildContext context)
  {

        var cubit=ShopCubit.get(context);
      return BlocConsumer<ShopCubit,ShopCubitStates>(builder:(context,state)
      {
        return  ConditionalBuilder(
            condition: cubit.homeModel!=null && cubit.categoryModel!=null ,
            builder: (context) => productsBuilder(cubit.homeModel,cubit.categoryModel,context),
            fallback: (context) =>const Center(child: CircularProgressIndicator()));
      } ,
        listener: (context,state)
        {
        if(state is ShopSuccessChangeFavoritesState)
          {
               if(!state.model.status)
                 {
                   showToast(txt: state.model.message, state: ToastStates.error);
                 }
          }
        },

      );

  }
 Widget buildGridProduct(model,context)
 {

   return GestureDetector(onTap: ()
   {
ShopCubit.get(context).showDescription(id:model.productId);
navigateTo(context, DescriptionScreen());
   },
     child: Container(
       color: Colors.white,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Stack(alignment: AlignmentDirectional.bottomStart,
             children: [
               Image(
                 image: NetworkImage('${model.image}'),
                 width: double.infinity,
                 height: 200,
               ),
               if(model.discount!=0)
                 Container(color: Colors.red,padding: EdgeInsets.symmetric(horizontal: 5.0),

                   child: Text(
                     'DiSCOUNT',
                     style: TextStyle(color: Colors.white,fontSize:9.0),),
                 )
             ],
           ),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Column(
               children: [
                 Text(
                   model.name,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                 ),
                 SizedBox(height: 15.0,),
                 Row(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       '${model.price.round()}',
                       style: TextStyle(color: defaultColor),
                     ),
                     SizedBox(
                       width: 5.0,
                     ),
                     if(model.discount!=0)
                       Text(
                         '${model.oldPrice.round()}',
                         style: TextStyle(
                           color: Colors.grey,
                           decoration: TextDecoration.lineThrough,
                         ),
                       ),
                     Spacer(),
                     CircleAvatar(radius: 20.0,
                       backgroundColor:
                       ShopCubit.get(context).favourites[model.productId]! ? defaultColor:Colors.grey,
                       child: IconButton(
                           onPressed: ()
                           {
                             ShopCubit.get(context).changeFavorites(model.productId);

                           },
                           color: Colors.white,
                           alignment: Alignment.topRight,

                           icon: Icon(Icons.favorite_border,

                           )),
                     )


                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     ),
   );}





}
