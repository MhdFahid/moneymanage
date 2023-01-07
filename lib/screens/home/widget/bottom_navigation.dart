import 'package:flutter/material.dart';
import 'package:moneymanage/screens/category/screen_category.dart';
import 'package:moneymanage/screens/transactions/screen_transaction.dart';
import 'package:moneymanage/screens/home/screen_home.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext context, int updated, Widget? _) {
        return BottomNavigationBar(
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          currentIndex: updated,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'Transaction',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Category',
              icon: Icon(Icons.category),
            ),
          ],
        );
      },
    );
  }
}
