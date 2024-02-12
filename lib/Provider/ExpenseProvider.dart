import 'package:expensetracker/Model/ExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseProvider extends ChangeNotifier {

  List<ExpenseModel> expenseList = [];
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  String? expenseCategory;
  List<String> categoryList = ['household', 'food', 'subscription', 'entertainment', 'other'];

  void selectExpenseCategory(int index){
    expenseCategory = categoryList[index];
    notifyListeners();
  }

  int totalExpense(){
    int totalExpense = 0;
    for(int i=0; i < expenseList.length; i++){
      totalExpense += expenseList[i].expenseAmount;
    }
    return totalExpense;
  }

  int categoryExpense(String categoryName){
    int categoryExpense = 0;
    for(int i=0; i < expenseList.length; i++){
      if(expenseList[i].expenseCategory == categoryName){
        categoryExpense += expenseList[i].expenseAmount;
      }
    }
    return categoryExpense;
  }

  void addExpense(BuildContext context){
    if(expenseNameController.text.isNotEmpty && expenseAmountController.text.isNotEmpty && expenseCategory != null){
      ExpenseModel expenseModel = ExpenseModel(expenseName: expenseNameController.text.trim(), expenseAmount: int.parse(expenseAmountController.text), expenseCategory: expenseCategory!, expenseDate: DateTime.now());
      expenseList.add(expenseModel);
      expenseNameController.clear();
      expenseAmountController.clear();
      expenseCategory = null;
      notifyListeners();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PLEASE FILL IN ALL THE FIELDS', style: GoogleFonts.oswald(color: Colors.white)), backgroundColor: const Color(0xff5A47D0)));
    }
  }

}