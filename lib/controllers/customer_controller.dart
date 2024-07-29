import 'package:customer_manager/models/customer.dart';
import 'package:customer_manager/models/address.dart';
import 'package:customer_manager/services/api_service.dart';
import 'package:flutter/material.dart';

class CustomerController with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  Future<void> addCustomer(Customer customer) async {
    // validate customer PAN details
    final panResponse = await ApiService.verifyPan(customer.pan);

    if (panResponse['isValid']) {
      customer.fullName = panResponse['fullName'];
    } else {
      throw Exception('Invalid PAN');
    }

    // add customer to list
    _customers.add(customer);
    notifyListeners();
  }

  Future<void> getPostcodeDetails(Address address) async {
    final response = await ApiService.getPostcodeDetails(address.postcode);

    address.city = response['city'][0]['name'];
    address.state = response['state'][0]['name'];
    notifyListeners();
  }

  void updateCustomer(Customer customer, int index) {
    _customers[index] = customer;
    notifyListeners();
  }

  void deleteCustomer(int index) {
    _customers.removeAt(index);
    notifyListeners();
  }
}
