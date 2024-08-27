import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
bool isLoading =true;
class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
    ));
  }
}

