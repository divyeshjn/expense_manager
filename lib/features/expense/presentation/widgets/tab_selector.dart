import 'package:flutter/material.dart';

class ExpenseTabSelector extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final Function(int) onTabSelected;

  const ExpenseTabSelector({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 48,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.pink.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.pink.shade700 : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
