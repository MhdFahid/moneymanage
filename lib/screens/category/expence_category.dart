import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanage/db/category_db.dart';
import 'package:moneymanage/models/category_model.dart';

class Expence extends StatelessWidget {
  const Expence({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenceCategoryNotifier,
      builder:
          (BuildContext context, List<CategoryModel> newList, Widget? child) {
        return ListView.separated(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          itemBuilder: (BuildContext context, int index) {
            final _category = newList[index];
            return Card(
              color: Color.fromARGB(179, 86, 86, 240),
              child: ListTile(
                  selectedColor: Color.fromARGB(174, 238, 104, 14),
                  title: Text(
                    _category.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDB().deleteCategory(_category.id);
                    },
                    icon: Icon(Icons.delete),
                  )),
            );
          },
          itemCount: newList.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
        );
      },
    );
  }
}
