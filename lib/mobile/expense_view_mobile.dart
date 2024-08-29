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
    void calculate() {
      for (int i = 0; i < viewModelProvider.expensesAmount.length; i++) {
        totalExpense =
            totalExpense + int.parse(viewModelProvider.expensesAmount[i]);
      }
      for (int i = 0; i < viewModelProvider.incomesAmount.length; i++) {
        totalIncome =
            totalIncome + int.parse(viewModelProvider.incomesAmount[i]);
      }
    }

    calculate();
    int budgetLeft = totalIncome - totalExpense;
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
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
                  size: 20.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await viewModelProvider.logout();
                }),
            SizedBox(
              height: 20.0,
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
                      height: 35,
                      width: 35,
                    )),
                IconButton(
                    onPressed: () async {
                      await launchUrl(
                          Uri.parse("https://github.com/Prashant-Bista"));
                    },
                    icon: Image.asset(
                      "assets/github.png",
                      height: 35,
                      width: 35,
                    ))
              ],
            )
          ],
        ),
      ),
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
              Container(
                height: 240.0,
                width: widthDevice / 1.5,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Poppins(
                          text: "Budget Left",
                          size: 14.0,
                          color: Colors.white,
                        ),
                        Poppins(
                          text: "Total Expense",
                          size: 14.0,
                          color: Colors.white,
                        ),
                        Poppins(
                          text: "Total Income",
                          size: 14.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                    RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          indent: 40.0,
                          endIndent: 40.0,
                          color: Colors.grey,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Poppins(
                          text: budgetLeft.toString(),
                          size: 14.0,
                          color: Colors.white,
                        ),
                        Poppins(
                          text: totalExpense.toString(),
                          size: 14.0,
                          color: Colors.white,
                        ),
                        Poppins(
                          text: totalIncome.toString(),
                          size: 14.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //add expense
              SizedBox(
                height: 40.0,
                width: 155.0,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      OpenSans(
                        text: "Add Expense",
                        size: 14.0,
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
                    await viewModelProvider.addExpense(context);
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              SizedBox(
                height: 40.0,
                width: 155.0,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      OpenSans(
                        text: "Add income",
                        size: 14.0,
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
                    await viewModelProvider.addIncome(context);
                  },
                ),
              ),
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: ListView.builder(
                          itemCount: viewModelProvider.expensesAmount.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Poppins(
                                    text: viewModelProvider.expensesName[index],
                                    size: 12.0),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Poppins(
                                      text: viewModelProvider
                                          .expensesAmount[index],
                                      size: 12.0),
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
                        border: Border.all(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                      ),
                      child: ListView.builder(itemCount:viewModelProvider.incomesAmount.length,itemBuilder: (BuildContext context, int index){
                        return  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Poppins(
                                text: viewModelProvider.incomesName[index],
                                size: 12.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Poppins(
                                  text: viewModelProvider
                                      .incomesAmount[index],
                                  size: 12.0),
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
