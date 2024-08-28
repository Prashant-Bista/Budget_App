import 'package:budget_app/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginViewWeb extends HookConsumerWidget {
  const LoginViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    TextEditingController _email = useTextEditingController();
    TextEditingController _password = useTextEditingController();
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/login_image.png",width: widthDevice/2.6,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _email,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  controller: _password,
                  textAlign: TextAlign.center,
                  // keyboardType: TextInputType.visiblePassword,
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
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: MaterialButton(
                        child: OpenSans(
                          text: "Register",
                          size: 25,
                          color: Colors.white,
                        ),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async{
                          await viewModelProvider.createUserWithEmailAndPassword(context, _email.text, _password.text);
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "OR",
                    style: GoogleFonts.pacifico(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: MaterialButton(
                        child: OpenSans(
                          text: "Login",
                          size: 25,
                          color: Colors.white,
                        ),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async{
                          await viewModelProvider.signInWithEmailAndPassword(context, _email.text, _password.text);

                        }),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              SignInButton(buttonType: ButtonType.google,
                  btnText: "Sign In With Google",
                  btnTextColor: Colors.white,
                  btnColor: Colors.black,
                  onPressed: ()async{
                if(kIsWeb){
                  await viewModelProvider.signInwithGoogleWeb(context);
                }
                else{
                  await viewModelProvider.signInwithGoogleMobile(context);
                }
                  })
            ],
          ),
        ],
      ),
    ));
  }
}
