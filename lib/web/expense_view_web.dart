import 'package:budget_app/components.dart';
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
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 17.0,
                              ),
                              OpenSans(
                                text: "Add Expense",
                                size: 17.0,
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
                        height: 50,
                        width: 160,
                      ),
                      SizedBox(
                        height: 45.0,
                        width: 160.0,
                        child: MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 17.0,
                              ),
                              OpenSans(
                                text: "Add Income",
                                size: 17.0,
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
                      )                    ]
                  )),
                  SizedBox(
                    width: 30.0,
                  ),

                  Container(
                    height: 300.0,
                    width: 280.0,
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
                              size: 17.0,
                              color: Colors.white,
                            ),
                            Poppins(
                              text: "Total Expense",
                              size: 17.0,
                              color: Colors.white,
                            ),
                            Poppins(
                              text: "Total Income",
                              size: 17.0,
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
                              size: 17.0,
                              color: Colors.white,
                            ),
                            Poppins(
                              text: totalExpense.toString(),
                              size: 17.0,
                              color: Colors.white,
                            ),
                            Poppins(
                              text: totalIncome.toString(),
                              size: 17.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  child: ListView.builder(itemCount:viewModelProvider.expensesAmount.length,itemBuilder: (BuildContext context, int index){
                    return  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Poppins(
                            text: viewModelProvider.expensesName[index],
                            size: 17.0,
                        color: Colors.white,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Poppins(
                              text: viewModelProvider
                                  .expensesAmount[index],
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
                                child: ListView.builder(itemCount:viewModelProvider.incomesAmount.length,itemBuilder: (BuildContext context, int index){
                                  return  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Poppins(
                                        text: viewModelProvider.incomesName[index],
                                        size: 17.0,
                                        color: Colors.white,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Poppins(
                                          text: viewModelProvider
                                              .incomesAmount[index],
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
