import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';

import '../network/components/components.dart';
class ShopLayout extends StatelessWidget
{
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var cubit =ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopCubitStates>(
      listener:(context,state){} ,
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          title: Text('Salla',
          style: TextStyle(fontWeight: FontWeight.bold),),actions:
        [
          IconButton(onPressed: ()
          {
            navigateTo(context, SearchScreen());

          }, icon: Icon(Icons.search))

        ],),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(currentIndex: cubit.currentIndex,
            onTap: (index)
        {
          cubit.changeIndex(index);
        },
            items:
        [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings')
        ]),
      ),
    );
  }
}
