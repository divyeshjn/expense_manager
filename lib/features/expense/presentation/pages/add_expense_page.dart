import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'add_items_bottom_page.dart';
import '../../domain/entities/expense_item.dart';
import '../../data/models/expense_model.dart';

class AddExpenseBottomSheet extends StatefulWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  List<ExpenseItem> _items = [];

  double _pendingAmount = 0.0;
  DateTime _selectedDate = DateTime.now();

  double get _calculatedBillingAmount {
    return _items.fold<double>(
      0,
      (sum, item) => sum + (double.tryParse(item.price) ?? 0.0),
    );
  }

  void _updatePendingAmount() {
    final totalBilling = _calculatedBillingAmount;
    final paid = double.tryParse(_paidController.text.trim()) ?? 0.0;

    setState(() {
      _pendingAmount = (totalBilling - paid).clamp(0, totalBilling);
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _openAddItemSheet() async {
    final updatedItems = await showModalBottomSheet<List<ExpenseItem>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return AddItemBottomSheet(
          existingItems: List<ExpenseItem>.from(_items),
        );
      },
    );

    if (updatedItems != null) {
      setState(() {
        _items = updatedItems;
        _updatePendingAmount();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd-MM-yyyy').format(_selectedDate);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'New Expense',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionLabel('Date'),
            const SizedBox(height: 8),
            _buildDatePicker(dateFormatted),

            const SizedBox(height: 20),
            _buildSectionLabel('Category Name'),
            const SizedBox(height: 8),
            _buildTextInput(_categoryController, hint: 'Enter category name'),

            const SizedBox(height: 20),
            _buildSectionLabel('Vendor Name (optional)'),
            const SizedBox(height: 8),
            _buildTextInput(_vendorController, hint: 'Enter vendor name'),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _openAddItemSheet,
                child: Text(_items.isEmpty ? 'Add Items' : 'Add / View Items'),
              ),
            ),

            const SizedBox(height: 24),

            _buildBillingPaidTable(),

            const SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final box = Hive.box<ExpenseModel>('expenses');
                    final model = ExpenseModel(
                      date: dateFormatted,
                      category: _categoryController.text.trim(),
                      vendor: _vendorController.text.trim(),
                      billingAmount: _calculatedBillingAmount,
                      paidAmount: double.tryParse(_paidController.text) ?? 0,
                      pendingAmount: _pendingAmount,
                      items: _items
                          .map((e) => ExpenseItemModel(
                                name: e.name,
                                quantity: e.quantity,
                                unit: e.unit,
                                price: e.price,
                              ))
                          .toList(),
                    );

                    box.add(model);
                    Navigator.pop(context, model);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16))
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingPaidTable() {
    return Column(
      children: [
        _buildAmountRow(
            'Total Amount', '₹ ${_calculatedBillingAmount.toStringAsFixed(2)}'),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Paid Amount',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _paidController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '₹ Paid',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => _updatePendingAmount(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildAmountRow('Pending Balance', '₹ ${_pendingAmount.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildAmountRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextInput(TextEditingController controller, {required String hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDatePicker(String formattedDate) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(formattedDate, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          IconButton(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today_outlined),
          ),
        ],
      ),
    );
  }
}
