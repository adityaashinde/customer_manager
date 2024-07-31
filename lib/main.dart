import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/customer_controller.dart';
import 'views/customer_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerController(),
      child: MaterialApp(
        title: 'Customer CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CustomerList(),
      ),
    );
  }
}
