import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout.dart';
import 'package:shop_app/modules/register/shopregisterScreen.dart';
import 'package:shop_app/network/shared/sharedPreferences/cache.dart';

import '../../logincubit/cubit.dart';
import '../../logincubit/states.dart';
import '../../network/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, ShopLoginStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    )),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16.0, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your Email address';
                              }
                            },
                            prefix: Icons.email_outlined,
                            label: 'Email Address'),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          onsubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: AppCubit.get(context).suffix,
                          suffixpressed: () {
                            AppCubit.get(context).ChangePasswordVisibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          prefix: Icons.lock_outline,
                          label: 'Password',
                          Ispassword: AppCubit.get(context).IsPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          builder: (context) => defaultButton(
                              function: ()
                              {
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              isUpper: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          condition: state is! ShopLoginLoadingState,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register')
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.model.status == true)
            {
              CacheHelper.saveData(key: 'token',
                  value: state.model.data!.token)
                  .then((value)
              {
                print(state.model.data!.token);
               // token=state.model.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            // showToast(txt: state.model.message, state: ToastStates.success);

            } else {
             showToast(txt: state.model.message!, state: ToastStates.error);
            }
          }
        },
      ),
    );
  }
}
