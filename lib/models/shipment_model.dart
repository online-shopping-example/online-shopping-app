class ShipmentModel {
  final String? id;
  final String customerId;
  final String firstname;
  final String lastname;
  final String streetName;
  final String streetNumber;
  final String zipCode;
  final String city;
  final String country;
  final String status;
  final String customerEmail;
  final DateTime createdAt;
  final String? addressNotes;
  final String? statusNote;
  final String? customerTelephone;
  final String? shipmentNo;
  final String? labelURL;

  ShipmentModel({
    this.id,
    required this.customerId,
    required this.firstname,
    required this.lastname,
    required this.streetName,
    required this.streetNumber,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.status,
    required this.customerEmail,
    required this.createdAt,
    required this.addressNotes,
    required this.statusNote,
    required this.customerTelephone,
    required this.shipmentNo,
    required this.labelURL,
  });

  ShipmentModel copy({
    String? id,
    String? customerId,
    String? firstname,
    String? lastname,
    String? streetName,
    String? streetNumber,
    String? zipCode,
    String? city,
    String? country,
    String? status,
    String? customerEmail,
    DateTime? createdAt,
    required String? addressNotes,
    required String? statusNote,
    required String? customerTelephone,
    required String? shipmentNo,
    required String? labelURL,
  }) =>
      ShipmentModel(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        streetName: streetName ?? this.streetName,
        streetNumber: streetNumber ?? this.streetNumber,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        country: country ?? this.country,
        status: status ?? this.status,
        customerEmail: customerEmail ?? this.customerEmail,
        createdAt: createdAt ?? this.createdAt,
        addressNotes: addressNotes,
        statusNote: statusNote,
        customerTelephone: customerTelephone,
        shipmentNo: shipmentNo,
        labelURL: labelURL,
      );

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'firstname': firstname,
        'lastname': lastname,
        'streetName': streetName,
        'streetNumber': streetNumber,
        'zipCode': zipCode,
        'city': city,
        'country': country,
        'status': status,
        'customerEmail': customerEmail,
        'createdAt': createdAt.toString(),
        'addressNotes': addressNotes,
        'statusNote': statusNote,
        'customerTelephone': customerTelephone,
        'shipmentNo': shipmentNo,
        'labelURL': labelURL,
      };

  static ShipmentModel fromJson(
    Map<String, dynamic> json,
    String shipmentId,
  ) {
    return ShipmentModel(
      id: shipmentId,
      customerId: json['customerId'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      streetName: json['streetName'],
      streetNumber: json['streetNumber'],
      zipCode: json['zipCode'],
      city: json['city'],
      country: json['country'],
      status: json['status'],
      customerEmail: json['customerEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      // json['createdAt'].toDate()
      addressNotes: json['addressNotes'],
      statusNote: json['statusNote'],
      shipmentNo: json['shipmentNo'],
      labelURL: json['labelURL'],
      customerTelephone: json[
          'customerTelephone'], //json['customerTelephone'].isEmpty ? null : json['customerTelephone'],
    );
  }
}
