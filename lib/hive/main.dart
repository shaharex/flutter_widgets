import 'package:counter_50/hive/hive_usage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<dynamic>('productsBB');
  await Hive.openBox<List<dynamic>>('cartB');
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}
