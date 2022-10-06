import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio/diohelper.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/get_carts.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_detail_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favorite_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/components/constants/constants.dart';
import 'package:shop_app/network/end_points.dart';
class ShopCubit extends Cubit<ShopCubitStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  HomeModel? homeModel;
  Map<int, bool> favourites = {};
  void getHomeData() {
    Diohelper.getdata(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.productId: element.in_favorites});
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoryModel;
  void getCategoriesData() {
    Diohelper.getdata(url: getCategories).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavModel changeFavModel;
  void changeFavorites(int productId) {
    emit(ShopLoadingGetFavoritesState());
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeColorIconButtonFav());
    Diohelper.postData(
            url: favorite, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(value.data);
      //lwo status false a3'ir color iconButton
      if (!changeFavModel.status) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    Diohelper.getdata(url: favorite, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    Diohelper.getdata(url: profile, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data.name);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserDataState());
    Diohelper.putData(
            data: {'name': name, 'email': email, 'phone': phone},
            url: updateProfile,
            token: token)
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data.name);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
  ProductDetails? details;
  void showDescription({int? id}) {
    emit(ShopLoadingDescriptionDataState());
    Diohelper.getdata(
      url: 'products/$id',
      token: token,
    ).then((value) {
      details = ProductDetails.fromJson(value.data);

      emit(ShopSuccessDescriptionDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorDescriptionDataState());
    });
  }

 Carts ? cart;
  void addToCart({  int ? id}) {
    emit(ShopLoadingAddToCartState());
    Diohelper.postData(
      token: token,
      url: Add_to_Cart,
      data: {'product_id': id},
    ).then(
      (value)
      {
        cart = Carts.fromJson(value.data);

        emit(ShopSuccessAddToCartState());
      },
    ).catchError(
      (error)
      {
        print(error.toString());
        emit(ShopErrorAddToCartState());
      },
    );
  }
 // DataCart ? carts;
  void getCarts()
  {
    emit(ShopLoadingGetCartsState());
    Diohelper.getdata(url: 'carts',token: token).then
      ((value)
    {
      cart=Carts.fromJson(value.data);
     // print(carts!.data.toString());
      emit(ShopSuccessGetCartsState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetCartsState());
    });
  }
}
