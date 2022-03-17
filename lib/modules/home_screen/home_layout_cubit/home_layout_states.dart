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

//get profile image
class HomeLoadingGetProfileImage extends HomeLayoutStates {}

class HomeSuccesGetProfileImage extends HomeLayoutStates {}

class HomeErrorGetProfileImage extends HomeLayoutStates {}

//get cover image
class HomeLoadingGetCoverImage extends HomeLayoutStates {}

class HomeSuccesGetCoverImage extends HomeLayoutStates {}

class HomeErrorGetCoverImage extends HomeLayoutStates {}

//get upload image
class HomeLoadingUploadProfileImage extends HomeLayoutStates {}

class HomeSuccesUploadProfileImage extends HomeLayoutStates {}

class HomeErrorUploadProfileImage extends HomeLayoutStates {}

//get cover image
class HomeLoadingUploadCoverImage extends HomeLayoutStates {}

class HomeSuccesUploadCoverImage extends HomeLayoutStates {}

class HomeErrorUploadCoverImage extends HomeLayoutStates {}

//update userData image
class HomeLoadingUpdateUserData extends HomeLayoutStates {}

class HomeSuccesUpdateUserData extends HomeLayoutStates {}

class HomeErrorUpdateUserData extends HomeLayoutStates {}

//get post image

class HomeSuccesGetPostImage extends HomeLayoutStates {}

class HomeErrorGetPostImage extends HomeLayoutStates {}

//create post
class HomeLoadingCreatePost extends HomeLayoutStates {}

class HomeSuccesCreatePost extends HomeLayoutStates {}

class HomeErrorCreatePost extends HomeLayoutStates {}

//get upload image
class HomeLoadingUploadPostImage extends HomeLayoutStates {}

class HomeSuccesUploadPostImage extends HomeLayoutStates {}

class HomeErrorUploadPostImage extends HomeLayoutStates {}

// remove post image
class HomeSuccesRemovePostImage extends HomeLayoutStates {}

//get posts lists
class HomeLoadingGetPostsLists extends HomeLayoutStates {}

class HomeSuccesGetPostsLists extends HomeLayoutStates {}

class HomeErrorGetPostsLists extends HomeLayoutStates {}

//get posts likrs

class HomeSuccesPostsLike extends HomeLayoutStates {}

class HomeErrorPostsLike extends HomeLayoutStates {}

//get posts likrs

class HomeLoadingGetAllUsers extends HomeLayoutStates {}

class HomeSuccesGetAllUsers extends HomeLayoutStates {}

class HomeErrorGetAllUsers extends HomeLayoutStates {}

//chat details

class HomeSuccesGetChat extends HomeLayoutStates {}

class HomeErrorGetChat extends HomeLayoutStates {}

class HomeSuccesSendChat extends HomeLayoutStates {}

class HomeErrorSendChat extends HomeLayoutStates {}

