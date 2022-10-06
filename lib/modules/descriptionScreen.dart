import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/add_to_cart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/product_detail_model.dart';
import '../styles/colors/colors.dart';

class DescriptionScreen extends StatelessWidget {
  var photocontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ShopCubit, ShopCubitStates>(
          builder: (context, state) {
            ProductData? model = ShopCubit.get(context).details?.data;

            return ConditionalBuilder(
              condition: state is! ShopLoadingDescriptionDataState,
              builder: (context) 
              {
               return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          child: PageView.builder(
                              controller: photocontroller,
                              itemCount: model!.images.length,
                              itemBuilder: (context, index) =>
                                  Image(image: NetworkImage(model.images[index])),
                              scrollDirection: Axis.horizontal),
                        ),
                      ),
                      Center(
                        child: SmoothPageIndicator(
                          effect: ScaleEffect(
                              activeDotColor: defaultColor,
                              dotHeight: 10,
                              dotWidth: 10,
                              dotColor: Colors.grey,
                              radius: 10),
                          controller: photocontroller,
                          count: model.images.length,
                        ),
                      ),
                      Text(
                        '${model.name}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                        maxLines: 2,
                      ),
                      Expanded(child: Text('${model.description}')),

                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: ()
                              {
                               ShopCubit.get(context).addToCart(id:model.id);
                               //  navigateTo(context, AddToCart());
                              },
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Container(color: defaultColor,width: 48,height: 36,
                            alignment: Alignment.center,
                            child: MaterialButton(onPressed: ()
                            {
                              ShopCubit.get(context).getCarts();

                                      Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>AddToCart()));
                            },
                              child: Icon(Icons.shopping_cart,
                                color: Colors.white,),),
                          ),
                        ],
                      ),



                    ],
                  ),
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {},
        ));
  }
}
