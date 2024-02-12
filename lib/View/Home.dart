import 'package:expensetracker/Provider/ExpenseProvider.dart';
import 'package:expensetracker/View/AddExpense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void showExpenseBottomSheet(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context){
        return const Scaffold(body: AddExpense());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              decoration: const BoxDecoration(
                  color: Color(0xffF5F5FC)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('dd MMM, yyyy').format(DateTime.now()).toUpperCase(), style: GoogleFonts.oswald()),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('EXPENSE TRACKER', style: GoogleFonts.bebasNeue(fontSize: 25.0, color: Colors.black)),
                          Text('HELLO, WELCOME BACK', style: GoogleFonts.oswald())
                        ],
                      ),
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage('assets/images/man.png'),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Consumer<ExpenseProvider>(
                    builder: (context, provider, tree){
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('TOTAL SPENDING', style: GoogleFonts.oswald(color: Colors.black)),
                                Text(provider.totalExpense().toString(), style: GoogleFonts.oswald(color: Colors.grey, fontSize: 18.0)),
                                const SizedBox(height: 10.0),
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: ListView(
                                    children: [
                                      Text('HOUSEHOLD', style: GoogleFonts.oswald(color: Colors.blue)),
                                      Text(provider.categoryExpense('household').toString(), style: GoogleFonts.oswald()),
                                      const SizedBox(height: 5.0),
                                      Text('FOOD', style: GoogleFonts.oswald(color: Colors.brown)),
                                      Text(provider.categoryExpense('food').toString(), style: GoogleFonts.oswald()),
                                      const SizedBox(height: 5.0),
                                      Text('SUBSCRIPTION', style: GoogleFonts.oswald(color: Colors.green)),
                                      Text(provider.categoryExpense('subscription').toString(), style: GoogleFonts.oswald()),
                                      const SizedBox(height: 5.0),
                                      Text('ENTERTAINMENT', style: GoogleFonts.oswald(color: Colors.deepPurpleAccent)),
                                      Text(provider.categoryExpense('entertainment').toString(), style: GoogleFonts.oswald()),
                                      const SizedBox(height: 5.0),
                                      Text('OTHER', style: GoogleFonts.oswald(color: Colors.grey)),
                                      Text(provider.categoryExpense('other').toString(), style: GoogleFonts.oswald())
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 120.0,
                              width: 120.0,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: provider.categoryExpense('household').toDouble(),
                                      title: 'HOUSEHOLD',
                                      showTitle: false,
                                      titleStyle: GoogleFonts.oswald(color: Colors.white),
                                      color: Colors.blue
                                    ),
                                    PieChartSectionData(
                                        value: provider.categoryExpense('food').toDouble(),
                                        title: 'FOOD',
                                        showTitle: false,
                                        titleStyle: GoogleFonts.oswald(color: Colors.white),
                                        color: Colors.brown
                                    ),
                                    PieChartSectionData(
                                        value: provider.categoryExpense('subscription').toDouble(),
                                        title: 'SUBSCRIPTION',
                                        showTitle: false,
                                        titleStyle: GoogleFonts.oswald(color: Colors.white),
                                        color: Colors.green
                                    ),
                                    PieChartSectionData(
                                        value: provider.categoryExpense('entertainment').toDouble(),
                                        title: 'ENTERTAINMENT',
                                        showTitle: false,
                                        titleStyle: GoogleFonts.oswald(color: Colors.white),
                                        color: Colors.deepPurpleAccent
                                    ),
                                    PieChartSectionData(
                                        value: provider.categoryExpense('other').toDouble(),
                                        title: 'OTHER',
                                        showTitle: false,
                                        titleStyle: GoogleFonts.oswald(color: Colors.white),
                                        color: Colors.grey
                                    )
                                  ]
                                )
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<ExpenseProvider>(
                builder: (context, provider, tree){
                  return Container(
                    padding: const EdgeInsets.all(15.0),
                    color: const Color(0xffE3E3FD),
                    child: ListView.builder(
                      itemCount: provider.expenseList.length,
                      itemBuilder: (context, int index){
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xff5A47D0),
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Text(provider.expenseList[index].expenseCategory.toUpperCase(), style: GoogleFonts.oswald(color: Colors.white)),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.expenseList[index].expenseName.toUpperCase(), style: GoogleFonts.oswald(color: Colors.black, fontSize: 18.0)),
                                    Text(DateFormat('dd MMM, yyyy').format(provider.expenseList[index].expenseDate).toUpperCase(), style: GoogleFonts.oswald(color: Colors.grey))
                                  ],
                                ),
                              ),
                              Text('${provider.expenseList[index].expenseAmount.toString()} INR', style: GoogleFonts.oswald(fontSize: 18.0))
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showExpenseBottomSheet();
        },
        backgroundColor: const Color(0xff5A47D0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
