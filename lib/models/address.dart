class Address {
  String addressLine1;
  String addressLine2;
  String postcode;
  String state;
  String city;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.postcode,
    required this.state,
    required this.city,
  });

  // This method turns an Address object into a format that can be easily save or sent
  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'postcode': postcode,
      'state': state,
      'city': city,
    };
  }

  // This factory method creates an Address object from the data that we get back from somewhere
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      postcode: json['postcode'],
      state: json['state'],
      city: json['city'],
    );
  }
}
