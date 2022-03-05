abstract class RegisterPageStates {}

class RegisterPageInitialState extends RegisterPageStates {}

class RegisterPageChangeEyePassword extends RegisterPageStates {}

class RegisterPageLoadingGetData extends RegisterPageStates {}

class RegisterPagesuccessGetData extends RegisterPageStates {}

class RegisterPageErrorGetData extends RegisterPageStates {
  final error;
  RegisterPageErrorGetData(this.error);
}

class RegisterPageLoadingSaveDataInFirebase extends RegisterPageStates {}

class RegisterPagesuccessSaveDataInFirebase extends RegisterPageStates {}

class RegisterPageErrorSaveDataInFirebase extends RegisterPageStates {
  final error;
  RegisterPageErrorSaveDataInFirebase(this.error);
}