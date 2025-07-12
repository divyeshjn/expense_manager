import 'package:flutter/material.dart';
import '../../domain/entities/expense_item.dart';

class ViewItemListPage extends StatefulWidget {
  final List<ExpenseItem> items;

  const ViewItemListPage({super.key, required this.items});

  @override
  State<ViewItemListPage> createState() => _ViewItemListPageState();
}

class _ViewItemListPageState extends State<ViewItemListPage> {
  late List<ExpenseItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List<ExpenseItem>.from(widget.items);
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (double.tryParse(item.price) ?? 0.0));
  }

  void _deleteItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _confirm() {
    Navigator.pop(context, _items);
  }

  void _addMore() {
    Navigator.pop(context, _items);
  }

  void _deleteAll() {
    Navigator.pop(context, <ExpenseItem>[]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // Table Headers
              Row(
                children: const [
                  Expanded(flex: 3, child: Text("Item Name", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 24),
                ],
              ),
              const Divider(thickness: 1),

              // Item Rows
              Expanded(
                child: _items.isEmpty
                    ? const Center(child: Text("No items added yet."))
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(flex: 3, child: Text(item.name)),
                                    Expanded(flex: 2, child: Text('${item.quantity} ${item.unit}')),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '₹ ${item.price}',
                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _deleteItem(index),
                                      icon: const Icon(Icons.close, color: Colors.red),
                                      tooltip: 'Delete Item',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Billing", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '₹ ${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

              const SizedBox(height: 12),

              // Add Items Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _addMore,
                  icon: const Icon(Icons.add, color: Colors.green),
                  label: const Text("Add Items", style: TextStyle(color: Colors.green)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Delete All Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _deleteAll,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Delete All", style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
