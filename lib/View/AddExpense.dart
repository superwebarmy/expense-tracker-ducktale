import 'package:expensetracker/Provider/ExpenseProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Consumer<ExpenseProvider>(
        builder: (context, provider, tree){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: provider.expenseNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'EXPENSE NAME',
                    hintStyle: GoogleFonts.oswald(),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.0))
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: provider.expenseAmountController,
                keyboardType: const TextInputType.numberWithOptions(),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'EXPENSE AMOUNT',
                    hintStyle: GoogleFonts.oswald(),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.0))
                ),
              ),
              const SizedBox(height: 15.0),
              Text('SELECT CATEGORY', style: GoogleFonts.oswald(color: Colors.grey, fontSize: 18.0)),
              const SizedBox(height: 15.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, mainAxisExtent: 60.0),
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, int index){
                    return InkWell(
                      onTap: (){
                        provider.selectExpenseCategory(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: provider.expenseCategory != null && provider.expenseCategory == provider.categoryList[index] ? const Color(0xff5A47D0) : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(child: Text(provider.categoryList[index].toUpperCase(), style: GoogleFonts.oswald(color: provider.expenseCategory != null && provider.expenseCategory == provider.categoryList[index] ? Colors.white : Colors.black))),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (){
                    provider.addExpense(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5A47D0)
                  ),
                  child: Text('ADD EXPENSE', style: GoogleFonts.oswald(color: Colors.white)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
