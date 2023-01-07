import 'package:flutter/material.dart';
import 'package:moneymanage/screens/category/category_popup.dart';
import 'package:moneymanage/screens/category/screen_category.dart';
import 'package:moneymanage/screens/home/widget/bottom_navigation.dart';
import 'package:moneymanage/screens/transactions/add_transaction.dart';
import 'package:moneymanage/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [ScreenTransaction(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 163, 39, 235),
        centerTitle: true,
        title: Text(
          'Maney Maneger'.toUpperCase(),
        ),
      ),
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: ValueListenableBuilder(
          builder: (BuildContext context, int value, Widget? _) =>
              _pages[value],
          valueListenable: selectedIndexNotifier,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (() {
          if (selectedIndexNotifier.value == 0) {
            ////addd transactio
            Navigator.pushNamed(context, TransactionAdd.routeName);
          } else {
            ///addd caterogies
            showCatergoryAddPopUp(context);
          }
        }),
      ),
    );
  }
}
