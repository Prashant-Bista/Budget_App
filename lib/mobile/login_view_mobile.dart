import 'package:budget_app/components.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginViewMobile extends HookConsumerWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _email = useTextEditingController();
    TextEditingController _password = useTextEditingController();
    double deviceHeight = MediaQuery.of(context).size.width;
    final viewModelProvider = ref.watch(viewModel);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight / 5.5,
            ),
            Image.asset(
              "assets/logo.png",
              fit: BoxFit.contain,
              width: 210.0,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 350.0,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                controller: _email,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  hintText: "Email",
                  hintStyle: GoogleFonts.openSans(),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 350.0,
              child: TextFormField(
                controller: _password,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        viewModelProvider.toggleObscured();
                      },
                      icon: Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.black,
                        size: 30,
                      )),
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.black,
                    size: 30,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Password",
                  hintStyle: GoogleFonts.openSans(),
                ),
                obscureText: viewModelProvider.isObscured,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //register button
                SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      splashColor: Colors.grey,
                      child: OpenSans(
                        text: "Register",
                        size: 25.0,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await viewModelProvider.createUserWithEmailAndPassword(
                            context, _email.text, _password.text);

                      }),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Or",
                  style:
                      GoogleFonts.pacifico(color: Colors.black, fontSize: 15.0),
                ),
                SizedBox(width: 20.0,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: MaterialButton(
                    
                      child: OpenSans(text: "Login", size: 25.0,color: Colors.white,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      onPressed: (){
                        viewModelProvider.signInWithEmailAndPassword(context, _email.text, _password.text);
                      },
                    padding: EdgeInsets.all(10),
                  ),
                ),

              ],
            ),
            SizedBox(height: 30.0,),

            SignInButton(
              buttonType: ButtonType.google,
              btnColor: Colors.black,
              btnTextColor: Colors.white,
              buttonSize: ButtonSize.medium,
              onPressed: ()async{
                if (kIsWeb){
                  await viewModelProvider.signInwithGoogleWeb(context);
                }
                else{
                  await viewModelProvider.signInwithGoogleMobile(context);
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
