import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/dio/diohelper.dart';
import 'package:shop_app/layouts/shop_layout.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/network/shared/sharedPreferences/cache.dart';
import 'package:shop_app/styles/styles/themes.dart';
import 'bloc_observer.dart';
import 'cubit/states.dart';
import 'modules/on_boarding/on_boarding _Screen.dart';
import 'network/components/constants/constants.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Diohelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
bool ? onboarding = CacheHelper.getData(key: 'onBoarding');
//bool isDark=CacheHelper.getData(key: 'isDark');
  token=CacheHelper.getData(key: 'token');
  print(token);
 late Widget widget;
print(onboarding);
if(onboarding!=null)
  {
    if(token!=null)
      {
          widget=ShopLayout();
      }
    else
      {
        widget=ShopLoginScreen();
      }
  }
else
  {
    widget=OnBoardingScreen();
  }

  runApp( ShopApp(onBoarding: onboarding,token: token,
  startWidget: widget,
));
}



class ShopApp extends StatelessWidget
{
 late bool isDark;
  bool ? onBoarding;
  String ? token;
late  Widget startWidget;
ShopApp({ this.onBoarding,required this.startWidget,required this.token});

  @override
  Widget build(BuildContext context)
  {
     return  BlocProvider(create: (context)=>ShopCubit()
       ..getHomeData()
       ..getCategoriesData()
       ..getFavorites()
       ..getUserData()
       ..getCarts()

     ,
       child: BlocConsumer<ShopCubit,ShopCubitStates>(
         builder:(context,state)=>MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: lightTheme,
           darkTheme: darkTheme,
           home: startWidget,

         ) ,
         listener: (context,state){},

       ),
     );
  }
}
