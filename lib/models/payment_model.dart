import 'package:online_shopping_app/models/shipment_model.dart';

import 'order_model.dart';

class PaymentModel {
  final String id;
  final int amount;
  final String currency;
  final String status;
  final List<dynamic> items;
  final ShipmentModel shipmentModel;
  final OrderModel orderModel;

  PaymentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.items,
    required this.shipmentModel,
    required this.orderModel,
  });

  PaymentModel copy({
    String? id,
    int? amount,
    String? currency,
    String? status,
    List<dynamic>? items,
    ShipmentModel? shipmentModel,
    OrderModel? orderModel,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        status: status ?? this.status,
        items: items ?? this.items,
        shipmentModel: shipmentModel ?? this.shipmentModel,
        orderModel: orderModel ?? this.orderModel,
      );

  static PaymentModel fromJson(
    Map<String, dynamic> json,
    String paymentId,
    ShipmentModel shipmentModel,
    OrderModel orderModel,
  ) {
    return PaymentModel(
      id: paymentId,
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      items: json['items'],
      shipmentModel: shipmentModel,
      orderModel: orderModel,
    );
  }
}
