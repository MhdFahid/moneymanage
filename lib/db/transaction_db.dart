import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanage/models/category_model.dart';
import 'package:moneymanage/models/transaction_model.dart';

const TRANSACTION = 'transaction-database';

abstract class TransactionBdFunctions {
  Future<List<TransactionModel>> getAllTrans();
  Future<void> addTransaction(TransactionModel obj);
  Future<void> deleTransaction(String id);
}

class TransactionBD implements TransactionBdFunctions {
  TransactionBD._internal();
  static TransactionBD instance = TransactionBD._internal();
  factory TransactionBD() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _TransactionDb = await Hive.openBox<TransactionModel>(TRANSACTION);
    _TransactionDb.put(obj.id, obj);
    refresh();
  }

  Future<void> refresh() async {
    final _list = await getAllTrans();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(_list);
    transactionNotifier.notifyListeners();
    print(_list);
  }

  @override
  Future<List<TransactionModel>> getAllTrans() async {
    final _TransactionDb = await Hive.openBox<TransactionModel>(TRANSACTION);
    return _TransactionDb.values.toList();
  }

  @override
  Future<void> deleTransaction(String id) async {
    final _TransactionDb = await Hive.openBox<TransactionModel>(TRANSACTION);
    await _TransactionDb.delete(id);
    refresh();
  }
}
