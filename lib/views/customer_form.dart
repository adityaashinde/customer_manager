import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/customer_controller.dart';
import '../models/customer.dart';
import '../models/address.dart';

class CustomerForm extends StatefulWidget {
  final Customer? customer;
  final int? index;

  CustomerForm({this.customer, this.index});

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  late String _pan;
  late String _fullName;
  late String _email;
  late String _mobile;
  late List<Address> _addresses;

  @override
  void initState() {
    super.initState();
    _pan = widget.customer?.pan ?? '';
    _fullName = widget.customer?.fullName ?? '';
    _email = widget.customer?.email ?? '';
    _mobile = widget.customer?.mobile ?? '';
    _addresses = widget.customer?.addresses ??
        [
          Address(
              addressLine1: '',
              addressLine2: '',
              postcode: '',
              state: '',
              city: '')
        ];
  }

  Future<void> _verifyPan(String pan) async {
    final customerController =
        Provider.of<CustomerController>(context, listen: false);
    try {
      final panResponse = await customerController.verifyPan(pan);
      setState(() {
        _fullName = panResponse['fullName'];
      });
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<void> _verifyPostcode(String postcode, int index) async {
    final customerController =
        Provider.of<CustomerController>(context, listen: false);
    try {
      final postcodeResponse =
          await customerController.getPostcodeDetails(postcode);
      setState(() {
        _addresses[index].city = postcodeResponse['city'][0]['name'];
        _addresses[index].state = postcodeResponse['state'][0]['name'];
      });
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final customer = Customer(
        pan: _pan,
        fullName: _fullName,
        email: _email,
        mobile: _mobile,
        addresses: _addresses,
      );

      try {
        final customerController =
            Provider.of<CustomerController>(context, listen: false);
        if (widget.index != null) {
          customerController.updateCustomer(customer, widget.index!);
        } else {
          await customerController.addCustomer(customer);
        }
        Navigator.of(context).pop();
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer != null ? 'Edit Customer' : 'Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _pan,
                decoration: InputDecoration(labelText: 'PAN'),
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid PAN';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pan = value!;
                },
                onChanged: (value) async {
                  _pan = value;
                  if (_pan.length == 10) {
                    await _verifyPan(_pan);
                  }
                },
              ),
              TextFormField(
                initialValue: _fullName,
                decoration: InputDecoration(labelText: 'Full Name'),
                maxLength: 140,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Full Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                maxLength: 255,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _mobile,
                decoration:
                    InputDecoration(labelText: 'Mobile', prefixText: '+91 '),
                maxLength: 10,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length != 10 ||
                      !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid Mobile Number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mobile = value!;
                },
              ),
              ..._addresses.asMap().entries.map((entry) {
                int index = entry.key;
                Address address = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address ${index + 1}'),
                    TextFormField(
                      initialValue: address.addressLine1,
                      decoration: InputDecoration(labelText: 'Address Line 1'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Address Line 1';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _addresses[index].addressLine1 = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: address.addressLine2,
                      decoration: InputDecoration(labelText: 'Address Line 2'),
                      onSaved: (value) {
                        _addresses[index].addressLine2 = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: address.postcode,
                      decoration: InputDecoration(labelText: 'Postcode'),
                      maxLength: 6,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 6 ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid Postcode';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _addresses[index].postcode = value!;
                      },
                      onChanged: (value) async {
                        _addresses[index].postcode = value;
                        if (value.length == 6) {
                          await _verifyPostcode(value, index);
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: address.city,
                      decoration: InputDecoration(labelText: 'City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid City';
                        }
                        return null;
                      },
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: address.state,
                      decoration: InputDecoration(labelText: 'State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid State';
                        }
                        return null;
                      },
                      enabled: false,
                    ),
                    if (index == _addresses.length - 1 &&
                        _addresses.length < 10)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _addresses.add(Address(
                                addressLine1: '',
                                addressLine2: '',
                                postcode: '',
                                state: '',
                                city: ''));
                          });
                        },
                        child: Text('Add Address'),
                      ),
                    if (_addresses.length > 1)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _addresses.removeAt(index);
                          });
                        },
                        child: Text('Remove Address'),
                      ),
                  ],
                );
              }).toList(),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.customer != null ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
