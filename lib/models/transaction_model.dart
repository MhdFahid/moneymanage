import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanage/models/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final CategoryType category;
  @HiveField(5)
  final CategoryModel categoryModel;
  @HiveField(6)
  String? id;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.category,
      required this.categoryModel}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
