import 'package:budget_app/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final controller;
  final digitsOnly;
  final validator;
  final hintText;
  const TextForm({super.key, @required this.text,@required this.containerWidth,@required this.controller, this.digitsOnly, @required this.validator, @required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OpenSans(text: text, size: 13.0),
          SizedBox(height: 5.0,),
          SizedBox( width: containerWidth,
          child:TextFormField(
            controller: controller,
            validator: validator,
            inputFormatters: digitsOnly!=null?[FilteringTextInputFormatter.digitsOnly]:[],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.purpleAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: Colors.purpleAccent,width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: Colors.red),
              ),
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              hintText: hintText,
            ),
          ) ,),

        ],);
  }
}


class Poppins extends StatelessWidget {
  final text;
final size;
final color;
final fontWeight;
const Poppins({super.key, @required this.text, @required this.size, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text.toString(),style: GoogleFonts.poppins(fontSize: size,color: color==null?Colors.black:color,fontWeight: fontWeight==null?FontWeight.normal:fontWeight),);
  }
}


class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  const OpenSans({super.key, @required this.text, @required this.size, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text.toString(),style: GoogleFonts.openSans(
      fontSize: size,
      color: color==null?Colors.black:color,
      fontWeight: fontWeight==null?FontWeight.normal:fontWeight,
    ),);
  }
}

DialogBox(BuildContext context, String title){
  return showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    contentPadding: EdgeInsets.all(32.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(width: 2.0,color: Colors.black)
    ),
    actions: [MaterialButton(child:OpenSans(text: "OK", size: 15.0,color: Colors.white,),onPressed: (){
      Navigator.pop(context);
    }, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.black,)],
    title: OpenSans(text: title, size: 20.0,color: Colors.black,),));
}
class EmailAndPassword extends StatefulWidget {
  final viewModel;
  final email;
  final password;
  const EmailAndPassword({super.key, this.viewModel, this.email, this.password});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: widget.email,
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
            controller: widget.password,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    widget.viewModel.toggleObscured();
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
            obscureText: widget.viewModel.isObscured,
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
                    await widget.viewModel.createUserWithEmailAndPassword(
                        context, widget.email.text, widget.password.text);

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
                  widget.viewModel.signInWithEmailAndPassword(context, widget.email.text, widget.password.text);
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
              await widget.viewModel.signInwithGoogleWeb(context);
            }
            else{
              await widget.viewModel.signInwithGoogleMobile(context);
            }
          },
        ),
      ],
    );
  }
}
class DrawerExpense extends StatelessWidget {
  final viewModelProvider;
  const DrawerExpense({super.key, this.viewModelProvider});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                child: CircleAvatar(
                  radius: 180.0,
                  backgroundColor: Colors.white,
                  child: Image(
                    height: 100,
                    image: AssetImage("assets/logo.png"),
                    filterQuality: FilterQuality.high,
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: Colors.black),
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          MaterialButton(
              elevation: 15.0,
              height: 50.0,
              minWidth: 150.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
              child: OpenSans(
                text: "Logout",
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () async {
                await viewModelProvider.logout();
              }),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        "https://www.linkedin.com/in/prashant-bista-9016b5270/"));
                  },
                  icon: Image.asset(
                    "assets/linkedin.png",
                    height: 40,
                    width: 40,
                  )),
              IconButton(
                  onPressed: () async {
                    await launchUrl(
                        Uri.parse("https://github.com/Prashant-Bista"));
                  },
                  icon: Image.asset(
                    "assets/github.png",
                    height: 40,
                    width: 40,
                  ))
            ],
          )
        ],
      ),
    );
  }
}


class AddingButtons extends StatefulWidget {
  final provider;
  final String name;
  final bool isweb;
  const AddingButtons({super.key, @required this.provider,required this.name, required this.isweb});

  @override
  State<AddingButtons> createState() => _AddingButtonsState();
}

class _AddingButtonsState extends State<AddingButtons> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 40.0,
        width: 155.0,
        child:MaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
            size: widget.isweb?17.0:14.0,
          ),
          OpenSans(
            text: widget.name,
            size: widget.isweb?17.0:14.0,
            color: Colors.white,
          )
        ],
      ),
      splashColor: Colors.grey,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () async {
        await widget.provider.addExpense(context);
      },
    ));
  }
}

