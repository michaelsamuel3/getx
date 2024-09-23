// ignore_for_file: prefer_const_constructors

import 'package:category_management/home/controller/getex_contoller.dart';
import 'package:category_management/home/model/hive_model/event_model.dart';
import 'package:category_management/home/presentation/expenseform.dart';
import 'package:category_management/home/presentation/homescreen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
await Hive.initFlutter();
Hive.registerAdapter(ExpenseAdapter());
await Hive.openBox<Expense>("expenses");
Get.put(ExpenseController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseForm(),
      getPages: [
        GetPage(name: "/", page: ()=>ExpenseForm()),
        GetPage(name: "/home", page: ()=>Home())
      ],
    );
  }
}
