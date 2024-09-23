// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import '../../controller/getex_contoller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 229, 195),
        title: Text(
          "category management system".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => SizedBox(
                  height: 360,
                  width: 360,
                  child: CalendarCarousel<Event>(
                    onDayPressed: (date, _) {
                      controller.loadExpenseForDate(date);
                    },
                    weekendTextStyle: TextStyle(color: Colors.red),
                    selectedDayButtonColor: Colors.blueAccent,
                    selectedDateTime: controller.selectedDate.value,
                    markedDatesMap: controller.markedDates.value,
                    markedDateWidget: Container(
                      color: Colors.green,
                      height: 4,
                      width: 4,
                    ),
                    markedDateShowIcon: true,
                    markedDateIconBuilder: (event) {
                      if (event.icon != null) {
                        return event.icon!;
                      }
                      return Icon(Icons.circle, color: Colors.red, size: 5);
                    },
                    daysHaveCircularBorder: true,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Expense: ₹${controller.totalExpense.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = controller.expenses[index];
                      return Card(
                        color: const Color.fromARGB(255, 237, 234, 221),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            expense.category,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text('₹${expense.amount.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              // Delete the expense and show a Snackbar
                              controller.deleteExpense(expense.key);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(backgroundColor:  const Color.fromARGB(255, 238, 229, 195),
                                  content: Text(
                                      'Expense of ₹${expense.amount} deleted successfully.',style: TextStyle(color: Colors.black),),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
