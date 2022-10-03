import 'package:shop_app/models/login_model.dart';

import '../models/change_favorites_model.dart';

abstract class ShopCubitStates{}
class ShopInitialState extends ShopCubitStates{}
class ShopChangeBottomNav extends ShopCubitStates{}
class ShopLoadingHomeDataState extends ShopCubitStates{}
class ShopSuccessHomeDataState extends ShopCubitStates{}
class ShopErrorHomeDataState extends ShopCubitStates{}
class ShopSuccessCategoriesState extends ShopCubitStates{}
class ShopErrorCategoriesState extends ShopCubitStates{}
class ShopSuccessChangeFavoritesState extends ShopCubitStates{
  final ChangeFavModel model;
  ShopSuccessChangeFavoritesState(this.model);

}
class ShopErrorChangeFavoritesState extends ShopCubitStates{}
class ShopChangeColorIconButtonFav extends ShopCubitStates{}
class ShopLoadingGetFavoritesState extends ShopCubitStates{}
class ShopSuccessGetFavoritesState extends ShopCubitStates{}
class ShopErrorGetFavoritesState extends ShopCubitStates{}

class ShopLoadingGetUserDataState extends ShopCubitStates{}
class ShopSuccessGetUserDataState extends ShopCubitStates
{
  ShopLoginModel ?usermodel;

  ShopSuccessGetUserDataState(this.usermodel);

}
class ShopErrorGetUserDataState extends ShopCubitStates{}


class ShopLoadingUpdateUserDataState extends ShopCubitStates{}
class ShopSuccessUpdateUserDataState extends ShopCubitStates
{
  ShopLoginModel ?usermodel;

  ShopSuccessUpdateUserDataState(this.usermodel);

}
class ShopErrorUpdateUserDataState extends ShopCubitStates{}

class ShopLoadingDescriptionDataState extends ShopCubitStates{}
class ShopSuccessDescriptionDataState extends ShopCubitStates{}
class ShopErrorDescriptionDataState extends ShopCubitStates{}