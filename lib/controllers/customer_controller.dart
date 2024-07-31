import 'package:flutter/material.dart';
import '../models/customer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerController with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  Future<void> addCustomer(Customer customer) async {
    _customers.add(customer);
    notifyListeners();
  }

  Future<void> updateCustomer(Customer customer, int index) async {
    _customers[index] = customer;
    notifyListeners();
  }

  Future<void> deleteCustomer(int index) async {
    _customers.removeAt(index);
    notifyListeners();
  }

  Future<Map<String, dynamic>> verifyPan(String pan) async {
    final response = await http.post(
      Uri.parse('https://lab.pixel6.co/api/verify-pan.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'panNumber': pan}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify PAN');
    }
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    final response = await http.post(
      Uri.parse('https://lab.pixel6.co/api/get-postcode-details.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'postcode': postcode}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get postcode details');
    }
  }
}
