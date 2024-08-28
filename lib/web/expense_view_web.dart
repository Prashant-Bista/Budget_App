import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
bool isLoading =true;
class ExpenseViewWeb extends HookConsumerWidget {
  const ExpenseViewWeb({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double widthDevice = MediaQuery.of(context).size.width;

    int totalExpense =0;
    int totalIncome =0;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("BUdgetapp"),

      ),
    ));
  }
}

