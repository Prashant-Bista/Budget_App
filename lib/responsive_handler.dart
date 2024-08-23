import 'package:budget_app/mobile/expense_view_mobile.dart';
import 'package:budget_app/mobile/login_view_mobile.dart';
import 'package:budget_app/view_model.dart';
import 'package:budget_app/web/expense_view_web.dart';
import 'package:budget_app/web/login_view_web.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveHandler extends HookConsumerWidget {
  const ResponsiveHandler({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
 final viewModelProvider =ref.watch(viewModel);
 //to update the issignedin value
 viewModelProvider.isLoggedin();
if(viewModelProvider.isSignedIn){
  return LayoutBuilder(builder: (context,constrains){
    if (constrains.maxWidth>800){
      return ExpenseViewWeb();
    }
    else
      return ExpenseViewMobile();

  });
}
else{
  return LayoutBuilder(builder: (context,constraints){
    if(constraints.maxWidth>800){
      return LoginViewWeb();
    }
    else
      return LoginViewMobile();
  });
}
  }
}
