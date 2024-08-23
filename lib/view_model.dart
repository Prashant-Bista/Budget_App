import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>((ref)=>ViewModel());

class ViewModel extends ChangeNotifier{
  final _auth=FirebaseAuth.instance;
  bool isSignedIn=false;
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
}
}