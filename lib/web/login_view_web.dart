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
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();
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
             SizedBox(height: 20,),
              EmailAndPassword(email: email,password: password,viewModel: viewModelProvider,),
              SizedBox(height: 20,),

            ])
              ])
    ));
  }
}
