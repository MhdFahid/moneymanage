import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(1)
  income,
  @HiveField(2)
  expence,
}

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDelected;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final String id;

  CategoryModel({
    required this.name,
    this.isDelected = false,
    required this.type,
    required this.id,
  });
}
