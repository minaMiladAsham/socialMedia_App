import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/login/login_screen.dart';
import 'package:socialmediaapp/modules/register/cubit/register_cubit.dart';
import 'package:socialmediaapp/modules/register/cubit/register_states.dart';
import 'package:socialmediaapp/shared/components/components.dart';
import '../../shared/constants/constants.dart';


class RegisterPage extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterPageStates>(
        listener: (context , state){
          if (state is RegisterPagesuccessGetData){
            navigateTo(context, LoginScreen());
            showToast(context, 'Registered Successfully');
          }else if (state is RegisterPageErrorGetData) showToast(context, state.error);
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register' ,style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold,color: defaultColor),),
                        Text('Add Fun to your Life'),
                        SizedBox(height: 20,),
                        defaultTextFormField(
                            controller: userNameController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.person,
                            text: 'User Name',
                            validator: (value){
                              if (value!.isEmpty){
                                return 'please enter your name';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: phoneController,
                            text: 'Phone',
                            prefix: Icons.phone,
                            keyboardType: TextInputType.number,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'please enter your phone';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: emailController,
                            text: 'Email',
                            prefix: Icons.email,
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'please enter your email';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: passwordController,
                            text: 'password',
                            prefix: Icons.lock,
                            keyboardType: TextInputType.text,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).passwordEye,
                            suffixIconPressed: (){
                              RegisterCubit.get(context).changePasswordEye();
                            },
                            validator: (value){
                              if (value!.isEmpty){
                                return 'please enter your password';
                              }else return null;
                            }
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is !RegisterPageLoadingGetData,
                          builder: (context)=>Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15.0),
                              color: defaultColor,
                            ),
                            width: double.infinity,
                            height: 40,
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: userNameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Text('REGISTER', style: TextStyle(color: Colors.white),),),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
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
