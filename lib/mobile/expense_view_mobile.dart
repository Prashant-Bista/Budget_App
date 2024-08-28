import 'package:budget_app/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model.dart';
bool isLoading =true;
class ExpenseViewMobile extends HookConsumerWidget {
  const ExpenseViewMobile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double widthDevice = MediaQuery.of(context).size.width;

    int totalExpense =0;
    int totalIncome =0;
    void calculate(){
      for(int i=0; i<viewModelProvider.expensesAmount.length;i++) {
        totalExpense =
            totalExpense + int.parse(viewModelProvider.expensesAmount[i]);
      }
      for(int i=0;i<viewModelProvider.incomesAmount.length;i++){
        totalIncome=totalIncome+int.parse(viewModelProvider.incomesAmount[i]);
      }
    }
    calculate();
    int budgetLeft= totalIncome-totalExpense;
    return SafeArea(child: Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                child:Container(
                  child: CircleAvatar(
                    radius: 180.0,
                    backgroundColor: Colors.white ,
                    child: Image(
                      height: 100,
                      image: AssetImage("assets/logo.png"),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width:1.0, color: Colors.black
                    ),
                  ),
                ) ),
            SizedBox(height: 10.0,),
            MaterialButton(
              elevation: 15.0,
              height: 50.0,
              minWidth:150.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
              child: OpenSans(text: "Logout", size: 20.0,color: Colors.white,),
                onPressed: ()async{
                  await viewModelProvider.logout();
            }),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: ()async{
                  await launchUrl(Uri.parse("https://www.linkedin.com/in/prashant-bista-9016b5270/"));
    }, icon: Image.asset("assets/linkedin.png",height: 35,width: 35,)),
                IconButton(onPressed: ()async{
                  await launchUrl(Uri.parse("https://github.com/Prashant-Bista"));
                }, icon: Image.asset("assets/github.png",height: 35,width: 35,))
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
        ),
        elevation: 20.0,
        iconTheme: IconThemeData( color:Colors.white,size: 30.0),
        backgroundColor: Colors.deepPurple,
        title: Center(child: OpenSans(text: "Budget App", size: 30.0,color: Colors.white,fontWeight: FontWeight.bold,),),

      ),
    ));
  }
}

