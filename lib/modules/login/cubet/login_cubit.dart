import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/login/cubet/login_cubit_states.dart';


class LoginPageCubit extends Cubit<LoginPageStates>{

  LoginPageCubit() : super(LoginPageInitialState());

  static LoginPageCubit get(context)=> BlocProvider.of(context);

  IconData passwordEye = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordEye (){
    isPassword =! isPassword;
    passwordEye = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LginPageChangeEyePassword());
  }

  void userLogin ({
  required String email , required String password,
}){
    emit(LoginPageLoadingGetData());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(LoginPageSuccessGetData(value.user!.uid));

    }).catchError((onError){
      emit(LoginPageErrorGetData(onError.toString()));
    });

  }
}

