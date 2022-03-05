import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/models/save_data_in_firebase/save_data_in_firebase_model.dart';
import 'package:socialmediaapp/modules/chat_screen/chat_screen.dart';
import 'package:socialmediaapp/modules/feed_screen/feed_screen.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/modules/new_post_screen/new_post_screen.dart';
import 'package:socialmediaapp/modules/settings_screen/settings_screen.dart';
import 'package:socialmediaapp/modules/users_screen/users_screen.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';



class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  saveDataInFirebaseModel? model;

  Future<void> getUserData() async {
    emit(HomeLoadingGetUserData());

    await FirebaseFirestore.instance
        .collection('usersData')
        .doc(uId)
        .get()
        .then((value) {
          model = saveDataInFirebaseModel.fromJson(value.data());
          print(model?.email);
          emit(HomeSuccesGetUserData());
    })
        .catchError((error) {
          print('errrrror ${error.toString()}');
          emit(HomeErrorGetUserData(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;

  void changeBottomNavBar (index){
    if (index == 2)
      emit(HomeAddPost());
    else{
      currentIndex = index;
      emit(HomeChangeBottomNavBar());
    }
  }
}
