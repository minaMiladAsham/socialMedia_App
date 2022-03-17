import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/models/save_data_in_firebase/save_data_in_firebase_model.dart';
import 'package:socialmediaapp/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterPageStates> {
  RegisterCubit() : super(RegisterPageInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData passwordEye = Icons.visibility_outlined;

  void changePasswordEye() {
    isPassword = !isPassword;
    passwordEye =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPageChangeEyePassword());
  }

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(RegisterPageLoadingGetData());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveDataInFireBase(
          email: email, phone: phone, name: name, uId: value.user!.uid,);
      emit(RegisterPagesuccessGetData());
    }).catchError((onError) {
      emit(RegisterPageErrorGetData(onError.toString()));
    });
  }

  void saveDataInFireBase(
      {required String email,
      required String phone,
      required String name,
      required String uId}) {
    emit(RegisterPageLoadingSaveDataInFirebase());
    saveDataInFirebaseModel model = saveDataInFirebaseModel(
        phone: phone,
        email: email,
        name: name,
        uId: uId,
        coverImage: 'https://img.freepik.com/free-photo/silhouette-person-city_23-2149211269.jpg?w=996',
        profileImage: 'https://img.freepik.com/free-photo/two-people-fall-love-shadow_181624-43697.jpg?w=740',
        bio: 'I am so Happy to Be Here Today'
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterPagesuccessSaveDataInFirebase());
    }).catchError((error) {
      print('save data error ${error.toString()}');
      emit(RegisterPageErrorSaveDataInFirebase(error.toString()));
    });
  }
}
