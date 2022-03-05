abstract class HomeLayoutStates {}

class HomeLayoutInitialState extends HomeLayoutStates {}

class HomeLoadingGetUserData extends HomeLayoutStates {}

class HomeSuccesGetUserData extends HomeLayoutStates {}

class HomeErrorGetUserData extends HomeLayoutStates {
  final String error;
  HomeErrorGetUserData (this.error);
}

class HomeChangeBottomNavBar extends HomeLayoutStates {}

class HomeAddPost extends HomeLayoutStates {}