import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanage/models/category_model.dart';

const CATEGORY_DB_NAME = 'category';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String value);
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenceCategoryNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _getAllCategories = await getCategories();
    incomeCategoryNotifier.value.clear();
    expenceCategoryNotifier.value.clear();
    await Future.forEach(
      _getAllCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryNotifier.value.add(category);
        } else {
          expenceCategoryNotifier.value.add(category);
        }
      },
    );
    incomeCategoryNotifier.notifyListeners();
    expenceCategoryNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
