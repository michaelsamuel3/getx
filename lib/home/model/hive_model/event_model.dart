import 'package:hive/hive.dart';
part 'event_model.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String category;
  Expense(
      {required this.id,
      required this.date,
      required this.amount,
      required this.category});
}
