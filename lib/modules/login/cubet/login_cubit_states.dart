abstract class LoginPageStates {}

class LoginPageInitialState extends LoginPageStates {}

class LginPageChangeEyePassword extends LoginPageStates {}

class LoginPageLoadingGetData extends LoginPageStates {}

class LoginPageSuccessGetData extends LoginPageStates {
  final String uId;
  LoginPageSuccessGetData(this.uId);
}

class LoginPageErrorGetData extends LoginPageStates {
  final error;
  LoginPageErrorGetData(this.error);
}