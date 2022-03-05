import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_screen.dart';
import 'package:socialmediaapp/modules/login/cubet/login_cubit.dart';
import 'package:socialmediaapp/modules/login/cubet/login_cubit_states.dart';
import 'package:socialmediaapp/modules/register/register_screen.dart';
import 'package:socialmediaapp/shared/cache_helper/cache_helper.dart';
import 'package:socialmediaapp/shared/components/components.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginPageCubit(),
      child: BlocConsumer<LoginPageCubit , LoginPageStates>(
        listener: (context , state) {
          if (state is LoginPageSuccessGetData){
            cacheHelper.saveDate(key: 'uIdkey', value: state.uId);
            navigateAndFinish(context, HomeScreen());
            showToast(context, 'SignIn Successfully');
          }else if (state is LoginPageErrorGetData) showToast(context, state.error);
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login' ,style: Theme.of(context).textTheme.headline4!.copyWith(color: defaultColor,fontWeight: FontWeight.bold),),
                        Text('Add Fun to your Life'),
                        SizedBox(height: 20,),
                        defaultTextFormField(
                            prefix: Icons.email,
                            text: 'Email',
                            keyboardType: TextInputType.text,
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please insert your email';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: passwordController,
                            text: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            prefix: Icons.lock,
                            suffix: LoginPageCubit.get(context).passwordEye,
                            suffixIconPressed: (){
                              LoginPageCubit.get(context).changePasswordEye();
                            },
                            isPassword: LoginPageCubit.get(context).isPassword,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter your password';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ConditionalBuilder(
                              condition: state is !LoginPageLoadingGetData,
                              builder: (context)=> Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(15.0),
                                  color: defaultColor,
                                ),
                                width: double.infinity,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: (){
                                    if (formKey.currentState!.validate()){
                                      LoginPageCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                      );
                                    }
                                  },
                                  child: Text('LOGIN', style: TextStyle(color: Colors.white),),),
                              ),
                              fallback: (context)=> Center(child: CircularProgressIndicator()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('don\'t Have an Account ?'),
                                TextButton(
                                  onPressed: (){
                                    navigateTo(context , RegisterPage());
                                  },
                                  child: Text('Register Now', style: TextStyle(color: defaultColor,),),),
                              ],
                            ),
                          ],

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
