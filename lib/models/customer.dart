import 'package:customer_manager/models/address.dart';

class Customer {
  String pan;
  String fullName;
  String email;
  String mobile;
  List<Address> addresses;

  Customer({
    required this.pan,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.addresses,
  });

  // This method turns a Customer object into a format that can be easily saved
  Map<String, dynamic> toJson() {
    return {
      'pan': pan,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }

  // This factory method creates a Customer object from the data that we get back from somewhere
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      pan: json['pan'],
      fullName: json['fullName'],
      email: json['email'],
      mobile: json['mobile'],
      addresses:
          (json['addresses'] as List).map((i) => Address.fromJson(i)).toList(),
    );
  }
}
