import 'package:budget_app/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
  const ExpenseViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double widthDevice = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;
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
                  },
                  icon: Icon(Icons.refresh))
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0))),
            elevation: 15.0,
            iconTheme: IconThemeData(color: Colors.white, size: 35.0),
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
              SizedBox(height: 50.0),
              Row(
                children: [
                  Image.asset("assets/login_image.png",width: deviceHeight/1.6,),
                  SizedBox(height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddingButtons(provider: viewModelProvider, name: "Add Expense", isweb: true,isincome: false,),
                      SizedBox(
                        height: 50,
                        width: 160,
                      ),
AddingButtons(provider: viewModelProvider, name: "Add Income", isweb: true,isincome: true,)                    ]
                  )),
                  SizedBox(
                    width: 30.0,
                  ),

  CompareBox(budgetLeft: budgetLeft, totalExpense: totalExpense, widthDevice: widthDevice,totalIncome: totalIncome,),
                  ]),
              SizedBox(
                height: 40.0,
              ),
              Divider(indent: widthDevice/4,
              endIndent: widthDevice/4,
              thickness: 3.0,),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                  children: [

                    Container(
              padding: EdgeInsets.all(15.0),
            height: 320.0,
            width: 260.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              border: Border.all(width: 1.0, color: Colors.redAccent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Poppins(
                    text: "Expenses",
                    size: 25.0,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  indent: 30.0,
                  endIndent: 30.0,
                  color: Colors.white,

                ),
                Container(
                  padding: EdgeInsets.all(7.0),
                  height: 210.0,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  child: ListView.builder(itemCount:viewModelProvider.expenses.length,itemBuilder: (BuildContext context, int index){
                    return  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Poppins(
                            text: viewModelProvider.expenses[index].name,
                            size: 17.0,
                        color: Colors.white,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Poppins(
                              text: viewModelProvider
                                  .expenses[index].amount,
                              size: 17.0,
                            color: Colors.white,),
                        )
                      ],
                    );
                  }),
                )

              ],
            )
        )
                ],
              ),
                  Column(
                    children: [
                      Container(

                          padding: EdgeInsets.all(15.0),
                          height: 320.0,
                          width: 260.0,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            border: Border.all(width: 1.0, color: Colors.lightGreen),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Poppins(
                                  text: "Incomes",
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              Divider(
                                indent: 30.0,
                                endIndent: 30.0,
                                color: Colors.white,

                              ),
                              Container(
                                padding: EdgeInsets.all(7.0),
                                height: 210.0,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1.0, color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                                ),
                                child: ListView.builder(itemCount:viewModelProvider.incomes.length,itemBuilder: (BuildContext context, int index){
                                  return  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Poppins(
                                        text: viewModelProvider.incomes[index].name,
                                        size: 17.0,
                                        color: Colors.white,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Poppins(
                                          text: viewModelProvider
                                              .incomes[index].amount,
                                          size: 17.0,
                                          color: Colors.white,),
                                      )
                                    ],
                                  );
                                }),
                              )

                            ],
                          )
                      )
                    ],
                  )]
                  )
                ],
              )            ,
              )
    );

  }
  }
