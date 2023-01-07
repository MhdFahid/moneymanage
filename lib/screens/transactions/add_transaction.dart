import 'package:flutter/material.dart';

import 'package:moneymanage/db/category_db.dart';
import 'package:moneymanage/db/transaction_db.dart';
import 'package:moneymanage/models/category_model.dart';
import 'package:moneymanage/models/transaction_model.dart';

class TransactionAdd extends StatefulWidget {
  const TransactionAdd({super.key});
  static const routeName = 'add-transaction';

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  CategoryType? currentType;
  DateTime? selecteDate;
  CategoryModel? selectegCategoryModel;
  String? _categoryID;
  final purposeEditingController = TextEditingController();
  final amountEditingController = TextEditingController();
  @override
  void initState() {
    currentType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: purposeEditingController,
              decoration: InputDecoration(hintText: 'Purpose'),
            ),
            TextField(
              controller: amountEditingController,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton.icon(
                    icon: Icon(Icons.calendar_today),
                    label: Text(selecteDate == null
                        ? 'Select Date'
                        : selecteDate.toString()),
                    onPressed: () async {
                      final datenow = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 20)),
                          lastDate: DateTime.now());
                      // print(datenow.toString());
                      if (datenow == null) {
                        return print('null');
                      } else {
                        setState(() {
                          selecteDate = datenow;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: currentType,
                        onChanged: (value) {
                          setState(() {
                            currentType = CategoryType.income;
                            _categoryID = null;
                          });
                        }),
                    Text('Income')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expence,
                        groupValue: currentType,
                        onChanged: (value) {
                          setState(() {
                            currentType = CategoryType.expence;
                            _categoryID = null;
                          });
                        }),
                    Text('Expence')
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
                value: _categoryID,
                hint: Text('Select Category'),
                items: (currentType == CategoryType.income
                        ? CategoryDB.instance.incomeCategoryNotifier
                        : CategoryDB.instance.expenceCategoryNotifier)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    onTap: () {
                      selectegCategoryModel = e;
                    },
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    _categoryID = v;
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: Text("Submit")),
          ]),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = purposeEditingController.text;
    final _amountText = amountEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (selecteDate == null) {
      return;
    }
    final parsedDouble = double.tryParse(_amountText);
    if (parsedDouble == null) {
      return;
    }
    final _traModel = TransactionModel(
        amount: parsedDouble,
        category: currentType!,
        categoryModel: selectegCategoryModel!,
        date: selecteDate!,
        purpose: _amountText);
    await TransactionBD.instance.addTransaction(_traModel);
    print(_traModel);
    Navigator.of(context).pop();
    TransactionBD.instance.refresh();
  }
}
