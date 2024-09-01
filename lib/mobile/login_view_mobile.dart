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
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();
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
            EmailAndPassword(viewModel: viewModelProvider,email: email,password: password,),
          ],
        ),
      ),
    ));
  }
}
