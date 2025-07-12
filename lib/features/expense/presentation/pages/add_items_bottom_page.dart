import 'package:flutter/material.dart';
import 'package:expense_manager/features/expense/presentation/pages/item_list_page.dart';
import '../../domain/entities/expense_item.dart';

class AddItemBottomSheet extends StatefulWidget {
  final List<ExpenseItem> existingItems;
  const AddItemBottomSheet({Key? key, this.existingItems = const []}) : super(key: key);

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> _unitOptions = ['KG', 'Litre', 'Gram', 'Unit/Piece'];
  String? _selectedUnit;

  late List<ExpenseItem> _items;

  bool get _isFormValid =>
      _itemNameController.text.trim().isNotEmpty &&
      _quantityController.text.trim().isNotEmpty &&
      _priceController.text.trim().isNotEmpty &&
      _selectedUnit != null;

  @override
  void initState() {
    super.initState();
    // Initialize local _items list from existingItems passed in
    _items = List<ExpenseItem>.from(widget.existingItems);
  }

  void _saveAndClose() {
    if (!_isFormValid) return;

    final item = ExpenseItem(
      name: _itemNameController.text.trim(),
      quantity: _quantityController.text.trim(),
      unit: _selectedUnit!,
      price: _priceController.text.trim(),
    );

    setState(() {
      _items.add(item);
    });

    // Return the full updated list on close
    Navigator.pop(context, _items);
  }

  void _saveAndNew() {
    if (!_isFormValid) return;

    final item = ExpenseItem(
      name: _itemNameController.text.trim(),
      quantity: _quantityController.text.trim(),
      unit: _selectedUnit!,
      price: _priceController.text.trim(),
    );

    setState(() {
      _items.add(item);
      _itemNameController.clear();
      _quantityController.clear();
      _priceController.clear();
      _selectedUnit = null;
    });
  }

  Future<void> _openViewList() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ViewItemListPage(items: _items),
    ),
  );

  if (result != null && result is List) {
    setState(() {
      _items = result.cast<ExpenseItem>();
    });
  }
}


  @override
  Widget build(BuildContext context) {
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
            // Top Row: Heading and View List Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Item',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _openViewList,
                  child: const Text("View List"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildLabeledField('Item Name*', _itemNameController, hint: 'Please type here'),
            const SizedBox(height: 16),

            // Quantity + Quantity Type in one row
            Row(
              children: [
                Expanded(
                  child: _buildLabeledField(
                    'Quantity*',
                    _quantityController,
                    hint: 'e.g. 2',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdownField()),
              ],
            ),

            const SizedBox(height: 16),
            _buildLabeledField(
              'Total Item Pricing*',
              _priceController,
              hint: '₹ 1000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            // Buttons stacked vertically
            Column(
              children: [
                _buildActionButton('Save & New', _saveAndNew),
                const SizedBox(height: 10),
                _buildActionButton('Save', _saveAndClose),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context, _items),
                  child: const Text('Cancel'),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    final isEnabled = _isFormValid;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.green : Colors.grey,
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildLabeledField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity Type*', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedUnit,
          onChanged: (val) => setState(() => _selectedUnit = val),
          decoration: const InputDecoration(
            hintText: 'Please select',
            border: OutlineInputBorder(),
          ),
          items: _unitOptions.map((unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
        ),
      ],
    );
  }
}
