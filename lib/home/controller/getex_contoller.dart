//ignore_for_file: await_only_futures

import 'package:category_management/home/model/functions/hive_functions.dart';
import 'package:category_management/home/model/hive_model/event_model.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  var selectedDate = DateTime.now().obs;
  var totalExpense = 0.0.obs;
  var markedDates = EventList<Event>(events: {}).obs;
  final ExpenseService _service = ExpenseService();

  @override
  void onInit() {
    super.onInit();
    loadExpenseForDate(DateTime.now());
    updateMarkedDates();
  }

  void loadExpenseForDate(DateTime date) async {
    selectedDate.value = date;
    expenses.value = await _service.getExpensesByDate(date);
    calculateTotal();
  }

  void addExpense(Expense expense) async {
    _service.addExpense(expense);

    loadExpenseForDate(selectedDate.value);
    updateMarkedDates();
  }

  void calculateTotal() {
    totalExpense.value = expenses.fold(0, (sum, item) => sum + item.amount);
  }

  // Delete an expense
  void deleteExpense(int key) {
    final box = Hive.box<Expense>('expenses');
    box.delete(key);
    loadExpenseForDate(selectedDate.value); // Reload expenses after deletion
  }

  void updateMarkedDates() async {
    List<Expense> allExpense = await _service.getAllExpense();
    Map<DateTime, List<Event>> eventMap = {};
    for (var expense in allExpense) {
      DateTime eventDate =
          DateTime(expense.date.year, expense.date.month, expense.date.day);

      if (eventMap.containsKey(eventDate)) {
        eventMap[eventDate]!.add(Event(date: eventDate));
      } else {
        eventMap[eventDate] = [Event(date: eventDate)];
      }
    }
    markedDates.value = EventList<Event>(events: eventMap);
  }
}
