import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String date;

  @HiveField(1)
  String category;

  @HiveField(2)
  String vendor;

  @HiveField(3)
  double billingAmount;

  @HiveField(4)
  double paidAmount;

  @HiveField(5)
  double pendingAmount;

  @HiveField(6)
  List<ExpenseItemModel> items;

  ExpenseModel({
    required this.date,
    required this.category,
    required this.vendor,
    required this.billingAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.items,
  });
}

@HiveType(typeId: 1)
class ExpenseItemModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String quantity;

  @HiveField(2)
  String unit;

  @HiveField(3)
  String price;

  ExpenseItemModel({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.price,
  });
}
