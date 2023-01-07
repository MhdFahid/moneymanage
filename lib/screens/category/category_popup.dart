import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanage/db/category_db.dart';
import 'package:moneymanage/models/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCatergoryAddPopUp(BuildContext context) async {
  final nameeditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        title: const Text('Add Category'),
        children: [
          TextFormField(
              controller: nameeditingController,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              RadioButton(title: 'Income', type: CategoryType.income),
              RadioButton(title: 'Expence', type: CategoryType.expence),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // ignore: no_leading_underscores_for_local_identifiers
              final _name = nameeditingController.text;
              if (_name.isEmpty) {
                return;
              }
              final _type = selectedCategoryNotifier.value;
              final _category = CategoryModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _name,
                type: _type,
              );
              CategoryDB.instance.insertCategory(_category);
              Navigator.pop(ctx);
            },
            child: Text('ADD'),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategoryNotifier,
      builder: (BuildContext context, CategoryType newValue, Widget? child) {
        return Row(
          children: [
            Radio<CategoryType>(
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            ),
            Text(title)
          ],
        );
      },
    );
  }
}
