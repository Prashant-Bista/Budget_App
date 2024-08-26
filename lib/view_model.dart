import 'package:budget_app/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>((ref)=>ViewModel());

class ViewModel extends ChangeNotifier{
  bool isObscured=true;
  final _auth=FirebaseAuth.instance;
  bool isSignedIn=false;
  var logger = Logger();
  //check if signed in
Future<void> isLoggedin() async{
  await _auth.authStateChanges().listen((User? user){
    if(user==null){
      isSignedIn=false;
    }
    else{
      isSignedIn=true;
    }
  });
  notifyListeners();
}
void toggleObscured(){
  isObscured= !(isObscured);
  notifyListeners();
}
  Future<void> createUserWithEmailAndPassword(BuildContext context,String email, String password) async{
  
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value)=> logger.d("Registration Successful")).onError((error,stackTrace){
      logger.d("Registration error $error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }
}

//Authentication