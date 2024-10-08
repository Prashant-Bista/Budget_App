
import 'dart:math';

import 'package:budget_app/components.dart';
import 'package:budget_app/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>((ref)=>ViewModel());
CollectionReference userCollection= FirebaseFirestore.instance.collection("users");
final authStateProvider =StreamProvider<User?>((ref){
  return ref.read(viewModel).authStateChange;
});
class ViewModel extends ChangeNotifier {
  bool isObscured = true;
  final _auth = FirebaseAuth.instance;

  // bool isSignedIn=false;
  var logger = Logger();
  List <Models> expenses = [];
  List <Models> incomes = [];

  Stream<User?> get authStateChange => _auth.authStateChanges();

  //check if signed in
// Future<void> isLoggedin() async{
//   await _auth.authStateChanges().listen((User? user){
//     if(user==null){
//       isSignedIn=false;
//     }
//     else{
//       isSignedIn=true;
//     }
//   });
//   notifyListeners();
// }
  void toggleObscured() {
    isObscured = !(isObscured);
    notifyListeners();
  }

//Authentication
//createUserWithEmailAndPassword
  Future<void> createUserWithEmailAndPassword(BuildContext context,
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("Registration Successful"))
        .onError((error, stackTrace) {
      logger.d("Registration error $error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  //signInWithEmailAndPassword
  Future<void> signInWithEmailAndPassword(BuildContext context, String email,
      String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("Login Successful"))
        .onError((error, stackTrace) {
      DialogBox(context, error.toString().replaceAll(RegExp("\\[.*?\\]"), ''));
    });
  }

  //signInwithGoogleWeb
  Future<void> signInwithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleAuthProvider).onError((error,
        stackTrace) =>
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ""))
    );
    logger.d(
        "Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }

  //signInwithGoogleMobile
  Future<void> signInwithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn()
        .signIn()
        .onError((error, stackTrae) => DialogBox(
        context, error.toString().replaceAll(RegExp('\\[.*?\\]'), "")));

    final GoogleSignInAuthentication? googleAuth = await googleuser
        ?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );
    await _auth.signInWithCredential(credential).then((value) {
      logger.d("Google Sign in successful");
    }).onError((error, stackTrace) {
      logger.d("Google Sign in error $error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ""));
    });

    logger.d(
        "Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }

  //
  Future<void> logout() async {
    await _auth.signOut();
  }

  Future addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    showDialog(context: context, builder: (BuildContext context) =>
        AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.all(32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Form(key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextForm(text: "Name",
                    containerWidth: 130.0,
                    controller: controllerName,
                    validator: (text) {
                      if (text
                          .toString()
                          .isEmpty) {
                        return "Required";
                      }
                    },
                    hintText: "Name"),
                SizedBox(width: 10.0,),
                TextForm(digitsOnly: true,
                    text: "Amount",
                    containerWidth: 100.0,
                    controller: controllerAmount,
                    validator: (text) {
                      if (text
                          .toString()
                          .isEmpty) {
                        return "Required";
                      }
                    },
                    hintText: "Amount"),
              ],
            ),),
          actions: [
            MaterialButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await userCollection.doc(_auth.currentUser!.uid).collection(
                      'expenses').add({
                    "name": controllerName.text,
                    "amount": controllerAmount.text,
                  }).onError((error, stackTrace) {
                    logger.d(" add expense error = $error");
                    return DialogBox(context, error.toString());
                  });
                  Navigator.pop(context);
                }
              }
              ,
              child: OpenSans(text: "Save", size: 15.0, color: Colors.white,),
              splashColor: Colors.grey,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

            )
          ],
        ));
  }

  Future addIncome(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    showDialog(context: context, builder: (BuildContext context) =>
        AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.all(32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Form(key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextForm(text: "Name",
                    containerWidth: 130.0,
                    controller: controllerName,
                    validator: (text) {
                      if (text
                          .toString()
                          .isEmpty) {
                        return "Required";
                      }
                    },
                    hintText: "Name"),
                SizedBox(width: 10.0,),
                TextForm(digitsOnly: true,
                    text: "Amount",
                    containerWidth: 100.0,
                    controller: controllerAmount,
                    validator: (text) {
                      if (text
                          .toString()
                          .isEmpty) {
                        return "Required";
                      }
                    },
                    hintText: "Amount"),
              ],
            ),),
          actions: [
            MaterialButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await userCollection.doc(_auth.currentUser!.uid).collection(
                      "incomes").add({
                    "name": controllerName.text,
                    "amount": controllerAmount.text,
                  }).onError((error, stackTrace) {
                    logger.d("add Income error =$error");
                    return DialogBox(context, error.toString());
                  });
                }
                Navigator.pop(context);
              },
              child: OpenSans(text: "Save", size: 15.0, color: Colors.white,),
              splashColor: Colors.grey,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

            )
          ],
        ));
  }

  void expensesStream() async {
    await for (var snapshot in FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("expenses")
        .snapshots()) {
      expenses = [];
      snapshot.docs.forEach((element) {
        expenses.add(Models.fromJson(element.data()));
      });

    }
    notifyListeners();
  }

  void incomesStream() async {
    await for (var snapshot in FirebaseFirestore.instance.collection("users")
        .doc(
        _auth.currentUser!.uid).collection("incomes").snapshots()) {
      incomes=[];
      snapshot.docs.forEach((element) {
        incomes.add(Models.fromJson(element.data()));
      });
    }
    notifyListeners();
  }
      Future<void> reset() async {
        await userCollection.doc(_auth.currentUser!.uid)
            .collection("expenses")
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
        await userCollection.doc(_auth.currentUser!.uid)
            .collection("incomes")
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        });
      }

    List<int> calculate( int totalExpense, int totalIncome) {
      for (int i = 0; i < expenses.length; i++) {
        totalExpense =
            totalExpense + int.parse(expenses[i].amount);
      }
      for (int i = 0; i < incomes.length; i++) {
        totalIncome =
            totalIncome + int.parse(incomes[i].amount);
      }
      return [totalExpense, totalIncome];
    }


}
