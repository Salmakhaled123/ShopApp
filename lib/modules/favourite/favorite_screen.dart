import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                          image: AssetImage('assets/images/wishlist.jpg')),
                    ),
                    Text(
                      'No favorites here ',
                      style: TextStyle(color: Colors.grey[400], fontSize: 18),
                    )
                  ],
                ),
            condition:
                ShopCubit.get(context).favoritesModel!.data.data.length == 0,
            fallback: (context) => ListView.separated(
                itemBuilder: (context, index) => buildProductList(
                    ShopCubit.get(context)
                        .favoritesModel!
                        .data
                        .data[index]
                        .product,
                    context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Divider(),
                    ),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length));
      },
      listener: (context, state) {},
    );
  }
}
