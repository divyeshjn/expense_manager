// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      date: fields[0] as String,
      category: fields[1] as String,
      vendor: fields[2] as String,
      billingAmount: fields[3] as double,
      paidAmount: fields[4] as double,
      pendingAmount: fields[5] as double,
      items: (fields[6] as List).cast<ExpenseItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.vendor)
      ..writeByte(3)
      ..write(obj.billingAmount)
      ..writeByte(4)
      ..write(obj.paidAmount)
      ..writeByte(5)
      ..write(obj.pendingAmount)
      ..writeByte(6)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseItemModelAdapter extends TypeAdapter<ExpenseItemModel> {
  @override
  final int typeId = 1;

  @override
  ExpenseItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseItemModel(
      name: fields[0] as String,
      quantity: fields[1] as String,
      unit: fields[2] as String,
      price: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
