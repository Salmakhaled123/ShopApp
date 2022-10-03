import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import '../../layouts/shop_layout.dart';
import '../../network/components/components.dart';
import '../../network/components/constants/constants.dart';
import '../../network/shared/sharedPreferences/cache.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
        builder: (context, state) {
          return Scaffold(
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
                          Text('REGISTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.black,
                                  )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your name';
                                }
                              },
                              prefix: Icons.person,
                              label: 'User Name'),
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
                            onsubmit: (value) {},
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixpressed: () {
                              RegisterCubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            prefix: Icons.lock_outline,
                            label: 'Password',
                            Ispassword: RegisterCubit.get(context).IsPassword,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Phone number';
                                }
                              },
                              prefix: Icons.phone,
                              label: 'Phone Number'),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'register',
                                isUpper: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                            condition: state is ! ShopRegisterLoadingState,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState) {
            if (state.model.status == true)
            {
              CacheHelper.saveData(key: 'token',
                  value: state.model.data!.token)
                  .then((value)
              {
                print(state.model.data!.token);
                 token=state.model.data!.token;
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
