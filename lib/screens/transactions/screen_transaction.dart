import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanage/db/category_db.dart';
import 'package:moneymanage/db/transaction_db.dart';
import 'package:moneymanage/models/category_model.dart';
import 'package:moneymanage/models/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionBD.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionBD.instance.transactionNotifier,
      builder: (BuildContext context, List<TransactionModel> newlist,
          Widget? child) {
        return ListView.separated(
          padding: EdgeInsets.all(20),
          itemBuilder: (BuildContext ctx, int index) {
            final _value = newlist[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: (ctx) {
                        TransactionBD.instance.deleTransaction(_value.id!);
                      },
                      icon: Icons.delete)
                ],
              ),
              key: Key(_value.id!),
              child: Card(
                  color: Color.fromARGB(179, 86, 86, 240),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                        backgroundColor: _value.category == CategoryType.income
                            ? Color.fromARGB(173, 40, 238, 14)
                            : Colors.red,
                        radius: 30,
                        child: Text(
                          parseDate(
                            _value.date,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                    title: Text(
                      'Rs ${_value.amount}',
                    ),
                    subtitle: Text(_value.category.name),
                  )),
            );
          },
          itemCount: newlist.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.last}\n${_splitDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
