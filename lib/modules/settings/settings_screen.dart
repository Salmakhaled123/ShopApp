import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/network/components/components.dart';
import 'package:shop_app/network/components/constants/constants.dart';

class SettingsScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopCubitStates>(
      builder: (context,state)
      {
        var model=ShopCubit.get(context).userModel;
        nameController.text=model!.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;
        return ConditionalBuilder(condition: ShopCubit.get(context).userModel!=null,
          builder:(context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(key: formKey,
                child: Column(
                  children:
                [
                  if(state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String ? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'name mustn\'t be empty';
                        }
                      },
                      prefix: Icons.person,
                      label: 'Name'),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String ? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Email mustn\'t be empty';
                        }
                      },
                      prefix: Icons.email,
                      label: 'Email Address'),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String ? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Phone mustn\'t be empty';
                        }
                      },
                      prefix: Icons.phone,
                      label: 'Phone'),
                  SizedBox(height: 20,),
                  defaultButton(function: ()
                  {
                    if(formKey.currentState!.validate())
                      {
                        ShopCubit.get(context).updateUserData
                          (name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }

                  }, text: 'Update'),
                  SizedBox(height: 20,),
                  defaultButton(function: ()
                  {
                    signOut(context);
                  }, text: 'LogOut')


                ],),
              ),
            ),
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
      listener: (context,state){},
    );
  }
}
