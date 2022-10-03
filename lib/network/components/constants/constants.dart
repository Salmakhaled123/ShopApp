import '../../../modules/login/loginScreen.dart';
import '../../shared/sharedPreferences/cache.dart';
import '../components.dart';

void signOut(context)
{
  CacheHelper.removeData(key:'token').then((value)
  {
    navigateAndFinish(context, ShopLoginScreen());
  });
}
String ? token;
