import 'package:flutter/material.dart';
import 'package:sqlite/database/database_helper.dart';
import 'package:sqlite/person/person.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().setDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: new Person());
  }
}
