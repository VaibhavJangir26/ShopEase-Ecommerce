import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastMessage{

  void showToastMsg(String msg){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.blue.shade200,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
    );
  }
}