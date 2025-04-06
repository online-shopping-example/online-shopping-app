class UserModel {
  final String? id;
  final String email;
  final String firstname;
  final String lastname;
  final String streetName;
  final String houseNumber;
  final String zipCode;
  final String city;
  final bool isAdmin;

  UserModel({
    this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.streetName,
    required this.houseNumber,
    required this.zipCode,
    required this.city,
    required this.isAdmin,
  });

  UserModel copy({
    String? id,
    String? email,
    String? firstname,
    String? lastname,
    String? streetName,
    String? houseNumber,
    String? zipCode,
    String? city,
    bool? isAdmin,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        streetName: streetName ?? this.streetName,
        houseNumber: houseNumber ?? this.houseNumber,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'streetName': streetName,
        'houseNumber': houseNumber,
        'zipCode': zipCode,
        'city': city,
        'isAdmin': isAdmin,
      };

  static UserModel fromJson(
    String userId,
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: userId,
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      streetName: json['streetName'],
      houseNumber: json['houseNumber'],
      zipCode: json['zipCode'],
      city: json['city'],
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}
