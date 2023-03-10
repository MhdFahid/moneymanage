import 'package:flutter/material.dart';
import 'package:moneymanage/db/category_db.dart';
import 'package:moneymanage/screens/category/expence_category.dart';
import 'package:moneymanage/screens/category/icome_category.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: [
            Tab(text: 'Income'.toUpperCase()),
            Tab(text: 'Expence'.toUpperCase())
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Income(),
              Expence(),
            ],
          ),
        )
      ],
    );
  }
}
