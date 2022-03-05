import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixIconPressed,
  bool isPassword=false,
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
  String? text,
})=> TextFormField(
  validator: validator,
controller: controller,
  obscureText: isPassword,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
        onPressed: suffixIconPressed,
        icon: Icon(suffix,),
    ),
    border: OutlineInputBorder(),
    labelText: text,
  ),
);

void navigateTo (context , Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
}

void navigateAndFinish (context , Widget page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contexr) => page), (route) => false);
}

void showToast(context  , String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0
  );
}