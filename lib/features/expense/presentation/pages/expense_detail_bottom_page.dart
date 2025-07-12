import 'package:flutter/material.dart';
import '../../data/models/expense_model.dart';

class ExpenseDetailBottomSheet extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseDetailBottomSheet({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              expense.category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${expense.date}', style: const TextStyle(color: Colors.grey)),
            if (expense.vendor.isNotEmpty) Text('Vendor: ${expense.vendor}'),

            const SizedBox(height: 16),
            const Divider(),

            // Table Header
            Row(
              children: const [
                Expanded(flex: 3, child: Text("Item Name", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("Cost", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 6),

            // Item Rows
            Column(
              children: expense.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(item.name)),
                      Expanded(flex: 2, child: Text('${item.quantity} ${item.unit}')),
                      Expanded(flex: 2, child: Text('₹ ${item.price}')),
                    ],
                  ),
                );
              }).toList(),
            ),

            const Divider(),

            // Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹ ${expense.billingAmount.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Paid", style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹ ${expense.paidAmount.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pending", style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹ ${expense.pendingAmount.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
