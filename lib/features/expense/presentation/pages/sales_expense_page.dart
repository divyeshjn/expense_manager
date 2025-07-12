import '../widgets/expense_tab_content.dart';
import 'package:flutter/material.dart';
import '../widgets/tab_selector.dart';

class SalesExpensePage extends StatefulWidget {
  const SalesExpensePage({super.key});

  @override
  State<SalesExpensePage> createState() => _SalesExpensePageState();
}

class _SalesExpensePageState extends State<SalesExpensePage> {
  int selectedIndex = 0;
  final List<String> tabs = ['Sales', 'Expense', 'Money Management'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sales & Expense',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.info_outline, size: 20, color: Colors.green),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ExpenseTabSelector(
            selectedIndex: selectedIndex,
            tabs: tabs,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: () {
              if (selectedIndex == 1) {
                // if expense is selected so we will see all the contents in the expense tab.
                return ExpenseTabContent();
              } else {
                return Center(
                  child: Text(
                    'Selected: ${tabs[selectedIndex]}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }
            }(),
          ),
        ],
      ),
    );
  }
}
