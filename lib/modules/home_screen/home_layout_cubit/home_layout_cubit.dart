import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmediaapp/models/chat_model/chat_model.dart';
import 'package:socialmediaapp/models/save_data_in_firebase/save_data_in_firebase_model.dart';
import 'package:socialmediaapp/modules/chat_screen/chat_screen.dart';
import 'package:socialmediaapp/modules/feed_screen/feed_screen.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/modules/new_post_screen/new_post_screen.dart';
import 'package:socialmediaapp/modules/settings_screen/settings_screen.dart';
import 'package:socialmediaapp/modules/users_screen/users_screen.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/post_model/post_model.dart';

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
    }).catchError((error) {
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

  void changeBottomNavBar(index) {
    if (index == 1)
      getAllUsers();
    if (index == 2)
      emit(HomeAddPost());
    else {
      currentIndex = index;
      emit(HomeChangeBottomNavBar());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  // Future<void> getProfileImage()async {
  //   await picker.pickImage(source: ImageSource.gallery)
  //       .then((value) {
  //     profileImage = File(value!.path);
  //    // uploadProfileImage();
  //     emit(HomeSuccesGetProfileImage());
  //   })
  //       .catchError((error){
  //     emit(HomeErrorGetProfileImage());
  //   })
  //
  //   ;
  // }

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeSuccesGetCoverImage());
    } else {
      print('error to get post image');
      emit(HomeErrorGetCoverImage());
    }
  }

  File? coverImage;

  // Future<void> getCoverImage()async {
  //   await picker.pickImage(source: ImageSource.gallery)
  //       .then((value) {
  //     coverImage = File(value!.path);
  //     //uploadCovermage();
  //     emit(HomeSuccesGetCoverImage());
  //   })
  //       .catchError((error){
  //     print(error.toString());
  //     emit(HomeErrorGetCoverImage());
  //   })
  //
  //   ;
  // }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeSuccesGetCoverImage());
    } else {
      print('error to get post image');
      emit(HomeErrorGetCoverImage());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
  }) {
    emit(HomeLoadingUploadProfileImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersData/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      emit(HomeSuccesUploadProfileImage());
      value.ref.getDownloadURL().then((value) {
        updateUserDate(name: name, bio: bio, proile: value);
        print(value);
      }).catchError((error) {});
    }).catchError((error) {
      print('upload profile error ${error}');
      emit(HomeErrorUploadProfileImage());
    });
  }

  void uploadCovermage({
    required String name,
    required String bio,
  }) {
    emit(HomeLoadingUploadCoverImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersData/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      emit(HomeSuccesUploadCoverImage());
      value.ref.getDownloadURL().then((value) {
        updateUserDate(name: name, bio: bio, cover: value);
        print(value);
      }).catchError((error) {});
    }).catchError((error) {
      emit(HomeErrorUploadCoverImage());
    });
  }

  void updateUserDate({
    required String name,
    required String bio,
    String? cover,
    String? proile,
  }) {
    emit(HomeLoadingUpdateUserData());

    saveDataInFirebaseModel updateModel = saveDataInFirebaseModel(
        phone: model?.phone,
        email: model?.email,
        name: name,
        uId: model?.uId,
        bio: bio,
        coverImage: cover ?? model?.coverImage,
        profileImage: proile ?? model?.profileImage);

    FirebaseFirestore.instance
        .collection('usersData')
        .doc(model?.uId)
        .update(updateModel.toMap())
        .then((value) {
      getUserData();
      emit(HomeSuccesUpdateUserData());
    }).catchError((error) {
      print('update user date error $error');
      emit(HomeErrorUpdateUserData());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(HomeSuccesGetPostImage());
    } else {
      print('error to get post image');
      emit(HomeErrorGetPostImage());
    }
  }

  void createPost({
    String? postImage,
    required String? text,
    required String? dateTime,
  }) {
    emit(HomeLoadingCreatePost());

    CreatePost postModel = CreatePost(
      name: model!.name,
      profileImage: model!.profileImage,
      uId: model!.uId,
      text: text,
      postImage: postImage == null ? '' : postImage,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(HomeSuccesCreatePost());
    }).catchError((error) {
      print('create post error $error');
      emit(HomeErrorCreatePost());
    });
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(HomeLoadingUploadPostImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      emit(HomeSuccesUploadPostImage());
      value.ref.getDownloadURL().then((value) {
        createPost(postImage: value, text: text, dateTime: dateTime);
        print(value);
      }).catchError((error) {});
    }).catchError((error) {
      emit(HomeErrorUploadPostImage());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(HomeSuccesRemovePostImage());
  }

  List<CreatePost> posts = [];
  List<String> postId = [];
  List<int> likesNum = [];

  void getPosts() {
    emit(HomeLoadingGetPostsLists());

    posts = [];
       FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((value) {
            value.docs.forEach((element) {
              element.reference
                  .collection('likes')
                  .get()
                  .then((value) {
                    likesNum.add(value.docs.length);
                postId.add(element.id);
                posts.add(CreatePost.fromJson(element.data()));
              });
            });
           emit(HomeSuccesGetPostsLists());
      })
          .catchError((error) {
            print('get posts list error ${error.toString()}');
        emit(HomeSuccesGetPostsLists());
      });
  }

  void postsLike (String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc('postsId')
        .collection('likes')
        .doc(model!.uId)
        .set({'likes':true}).then((value){
          emit(HomeSuccesPostsLike());
    }).catchError((error) {
      emit(HomeErrorPostsLike());
    });
  }
  List<saveDataInFirebaseModel> users = [] ;
  void getAllUsers (){
    emit(HomeSuccesGetAllUsers());
    if(users.length == 0)
    FirebaseFirestore.instance
    .collection('usersData')
    .get()
    .then((value) {
      value.docs.forEach((element) {
        if(element.id != model!.uId)
             users.add(saveDataInFirebaseModel.fromJson(element.data()));
        emit(HomeSuccesGetAllUsers());
      });
    }).catchError((error){
      emit(HomeErrorGetAllUsers());
    });
  }

  void sendMessage({
    required String? receiverId,
    required String dateTime,
    required String text,
  }){

    ChatModel chatModel = ChatModel(
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: model?.uId,
      text: text,
    );

    FirebaseFirestore.instance
    .collection('usersData')
    .doc(model?.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(chatModel.toMap()).then((value) {
      emit(HomeSuccesSendChat());
    }).catchError((error){
      emit(HomeErrorSendChat());
    });

    FirebaseFirestore.instance
        .collection('usersData')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uId)
        .collection('messages')
        .add(chatModel.toMap()).then((value) {
      emit(HomeSuccesSendChat());
    }).catchError((error){
      emit(HomeErrorSendChat());
    });
  }

  List<ChatModel> messages = [];

  void getMessages ({
    required String? receiverId,
}){
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots().listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(HomeSuccesGetChat());
    });
  }
}


