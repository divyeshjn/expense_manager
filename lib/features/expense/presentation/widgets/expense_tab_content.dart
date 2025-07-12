import 'package:expense_manager/features/expense/presentation/pages/expense_detail_bottom_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../pages/add_expense_page.dart';
import '../../data/models/expense_model.dart';

class ExpenseTabContent extends StatefulWidget {
  const ExpenseTabContent({super.key});

  @override
  State<ExpenseTabContent> createState() => _ExpenseTabContentState();
}

class _ExpenseTabContentState extends State<ExpenseTabContent> {
  final _expenseBox = Hive.box<ExpenseModel>('expenses');
  List<ExpenseModel> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpensesFromHive();
  }

  void _loadExpensesFromHive() {
    setState(() {
      _expenses = _expenseBox.values.toList();
    });
  }

  void _showExpenseDetails(ExpenseModel expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ExpenseDetailBottomSheet(expense: expense),
    );
  }

  void _openAddExpenseSheet() async {
    final newExpense = await showModalBottomSheet<ExpenseModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const AddExpenseBottomSheet(),
    );

    if (newExpense != null) {
      await _expenseBox.add(newExpense);
      // Refresh UI
      setState(() {
        _expenses = _expenseBox.values.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              _buildFakeInputBox(),
              const SizedBox(height: 4),
              _buildFixedCategory(title: 'Salaries'),
              const SizedBox(height: 8),
              _buildFixedCategory(title: 'Fixed Expense'),
              const SizedBox(height: 8),
              ..._expenses.map(_buildExpenseCard),
            ],
          ),
        ),
        Positioned(
          bottom: 32,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: _openAddExpenseSheet,
            shape: const CircleBorder(),
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFakeInputBox() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: const Row(
          children: [
            Text(
              'Type here to add more category',
              style: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixedCategory({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard(ExpenseModel expense) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: GestureDetector(
        onTap: () => _showExpenseDetails(expense),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    textAlign: TextAlign.center,
                    expense.category,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}