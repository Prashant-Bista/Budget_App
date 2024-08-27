
import 'package:budget_app/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<void> signInWithEmailAndPassword(BuildContext context, String email,String password) async{
  await _auth.signInWithEmailAndPassword(email: email, password: password).then((value)=>logger.d("Login Successful")).onError((error,stackTrace){
    DialogBox(context, error.toString().replaceAll(RegExp("\\[.*?\\]"), ''));
  });
  }
  Future<void> signInwithGoogleWeb(BuildContext context) async{
  GoogleAuthProvider googleAuthProvider= GoogleAuthProvider();
  await _auth.signInWithPopup(googleAuthProvider).onError((error,stackTrace)=>
    DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ""))
  );
  logger.d("Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }
  Future<void> signInwithGoogleMobile(BuildContext context) async{
  final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn().onError((error,stackTrae)=>DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), "")));
  final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;
final credential= GoogleAuthProvider.credential(
  accessToken: googleAuth?.accessToken,
  idToken: googleAuth?.idToken
);
await _auth.signInWithCredential(credential).then((value){
  logger.d("Google Sign in successful");
}).onError((error,stackTrace){
  logger.d("Google Sign in error $error");
  DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ""));
});

    logger.d("Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }
}

//Authentication