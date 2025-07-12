import 'package:expense_manager/features/expense/data/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/expense/presentation/pages/sales_expense_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(ExpenseItemModelAdapter());
  await Hive.openBox<ExpenseModel>('expenses');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SalesExpensePage(),
    );
  }
}
