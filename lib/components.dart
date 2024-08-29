import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
