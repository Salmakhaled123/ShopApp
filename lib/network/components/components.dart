import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../cubit/cubit.dart';
import '../../styles/colors/colors.dart';
 void navigateTo(BuildContext context,widget)=>Navigator.push(context,
     MaterialPageRoute(builder: (context)=>widget));
void navigateAndFinish(BuildContext context,widget)=>Navigator.pushAndRemoveUntil(
    context,MaterialPageRoute(builder: (con)=>widget),
        (route) => false);
Widget defaultFormField({
  required TextEditingController controller
  , required TextInputType ? type,
  Function (String)? onsubmit,
  Function (String) ? onchanged,
  required FormFieldValidator<String>?validate,
  required IconData prefix,
  required String label,
  bool  Ispassword=false,
  IconData ?suffix,
  bool readonly=false,
  GestureTapCallback? ontap,
  final VoidCallback? suffixpressed
})=>TextFormField(readOnly:readonly ,
  onTap:ontap ,
  validator: validate,
  obscureText:Ispassword ,
  controller: controller,
keyboardType: type,
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),suffixIcon:suffix !=null ? IconButton(icon: Icon(suffix),
    onPressed: suffixpressed,): null ,
      border:const  OutlineInputBorder()),
  onFieldSubmitted:onsubmit ,
  onChanged: onchanged
  ,);
Widget defaultButton({
  double width = double.infinity,
  bool isUpper = true,
  Color background = Colors.indigo,
  required Function function,
  required String text,
  double radius = 0.0,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
Widget defaultTextButton({required String text,
required  void Function() function})=>TextButton(onPressed: function, child: Text(text.toUpperCase(),
  style: TextStyle(fontWeight: FontWeight.bold),));

void showToast({required String txt,required ToastStates state})=> Fluttertoast.showToast(
    msg: txt,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:changeToastColor(state) ,
    textColor: Colors.white,
    fontSize: 16.0);
enum ToastStates{success,error,warning}

Color changeToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color= Colors.green;
      break;
    case ToastStates.warning:
      color= Colors.amber;
       break;
    case ToastStates.error:
     color= Colors.red;
          break;
  }
  return color;
}
Widget buildProductList( model,context,{bool isOldPrice=true})
{
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120,

              ),
              if(model!.discount!=0 && isOldPrice)
                Container(color: Colors.red,padding: EdgeInsets.symmetric(horizontal: 5.0),

                  child: Text(
                    'DiSCOUNT',
                    style: TextStyle(color: Colors.white,fontSize:9.0),),
                )
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(color: defaultColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount!=0 && isOldPrice)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(radius: 20.0,
                      backgroundColor:
                      ShopCubit.get(context).favourites[model.id]! ? defaultColor:Colors.grey,
                      child: IconButton(
                          onPressed: ()
                          {
                            ShopCubit.get(context).changeFavorites(model!.id);

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
  );
}
Widget SearchProduct( model,context)=>  Row(

  children: [

    Image(

      image:

      NetworkImage('${model.image}',

      ),width: 100,height: 100,),



    Expanded(

      child: Padding(

        padding: const EdgeInsets.all(20.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text('${model.name}',

              style: TextStyle(fontSize: 18.0),

              overflow: TextOverflow.ellipsis,

              maxLines: 2,),

            SizedBox(height: 15.0,),

            Row(

              children: [

                Text('${model.price.round()}',style: TextStyle(fontSize: 16.0),),

                Spacer(),

                CircleAvatar(radius: 20.0,

                  backgroundColor:

                  ShopCubit.get(context).favourites[model.id]! ? defaultColor:Colors.grey,

                  child: IconButton(

                      onPressed: ()

                      {
                        ShopCubit.get(context).changeFavorites(model.id);

                      },

                      color: Colors.white,

                      alignment: Alignment.topRight,



                      icon: Icon(Icons.favorite_border,



                      )),

                )

              ],

            ),

          ],),

      ),

    )

  ],

);


