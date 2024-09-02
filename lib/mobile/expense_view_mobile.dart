import 'package:budget_app/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double widthDevice = MediaQuery.of(context).size.width;
    if(isLoading==true){
      viewModelProvider.incomesStream();
      viewModelProvider.expensesStream();
      isLoading=false;
    }
    int totalExpense = 0;
    int totalIncome = 0;
    List<int> values= viewModelProvider.calculate(totalExpense,totalIncome);
    totalExpense=values[0];
    totalIncome=values[1];
    int budgetLeft = totalIncome - totalExpense;
    return SafeArea(
        child: Scaffold(
      drawer: DrawerExpense(viewModelProvider: viewModelProvider,),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                viewModelProvider.reset();
                budgetLeft=0;
              },
              icon: Icon(Icons.refresh))
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0))),
        elevation: 20.0,
        iconTheme: IconThemeData(color: Colors.white, size: 30.0),
        backgroundColor: Color(0xFFA435F0),
        title: Center(
          child: Poppins(
            text: "Budget App",
            size: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 40.0),
          Column(
            children: [
              CompareBox(widthDevice: widthDevice, totalExpense: totalExpense,totalIncome: totalIncome,budgetLeft: budgetLeft,),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //add expense
              AddingButtons(provider: viewModelProvider, name: "Add Expense", isweb: false,isincome: false,),
              SizedBox(
                width: 10.0,
              ),
          AddingButtons(provider: viewModelProvider, name: "Add Income", isweb: false,isincome: true,),


            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //expense list
                Column(
                  children: [
                    OpenSans(text: "Expenses", size: 15.0),
                    Container(
                      padding: EdgeInsets.all(7.0),
                      height: 210.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        border: Border.all(width: 1.0, color: Colors.red),
                      ),
                      child: ListView.builder(
                          itemCount: viewModelProvider.expenses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                    text: viewModelProvider.expenses[index].name,
                                    size: 14.0),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                      text: viewModelProvider
                                          .expenses[index].amount,
                                      size: 14.0),
                                )
                              ],
                            );
                          }),
                    )
                  ],
                ),
                Column(
                  children: [
                    OpenSans(text: "Incomes", size: 15.0,color: Colors.black,),
                    Container(
                      padding: EdgeInsets.all(7.0),
                      height: 210.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(width: 1.0, color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                      ),
                      child: ListView.builder(itemCount:viewModelProvider.incomes.length,itemBuilder: (BuildContext context, int index){
                        return  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Poppins(
                                text: viewModelProvider.incomes[index].name,
                                size: 14.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Poppins(
                                  text: viewModelProvider
                                      .incomes[index].amount,
                                  size: 14.0),
                            )
                          ],
                        );
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
