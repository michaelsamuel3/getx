import 'package:category_management/home/model/hive_model/event_model.dart';
import 'package:hive/hive.dart';

class ExpenseService {
  final _expenseBox = Hive.box<Expense>("expenses");

  List<Expense> getAllExpense() {
    return _expenseBox.values.toList();
  }

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
  }

  Future<List<Expense>> getExpensesByDate(DateTime date) async {
    final box = await Hive.openBox<Expense>("expenses");
    return box.values
        .where((expense) =>
            expense.date.year == date.year &&
            expense.date.month == date.month &&
            expense.date.day == date.day)
        .toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
