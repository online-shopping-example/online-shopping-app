class OrderModel {
  final String? id;
  final String customerId;
  final DateTime createdAt;
  final List<Map<String, List<String>>> // we have to decide 
  order; //{offer name: List of pieces names}


  OrderModel({
    this.id,
    required this.customerId,
    required this.createdAt,
    required this.order,
  });

  OrderModel copy({
    String? id,
    String? customerId,
    DateTime? createdAt,
    List<Map<String, List<String>>>? order,
  }) =>
      OrderModel(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        createdAt: createdAt ?? this.createdAt,
        order: order ?? this.order,
      );

  Map<String, dynamic> toJson() =>
      {
        'customerId': customerId,
        'createdAt': createdAt.toString(),
        'order': order,
      };

  static OrderModel fromJson(Map<String, dynamic> json,
      String orderId,) {
    List<Map<String, List<String>>> ordersList = [];
    List<dynamic> jsonOrders = json['order'];
    for (Map<dynamic, dynamic> jsonOrder in jsonOrders) {
      Map<String, List<String>> product = {};
      for (dynamic key in jsonOrder.keys) {
        String keyString = key.toString();
        List<String> castList = List.from(jsonOrder[key]);
        product[keyString] = castList;
      }
      ordersList.add(product);
    }
    return OrderModel(
      id: orderId,
      customerId: json['customerId'],
      createdAt: DateTime.parse(json['createdAt']),
      order: ordersList,
    );
  }
}
