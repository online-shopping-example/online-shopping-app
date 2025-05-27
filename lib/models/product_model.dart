import 'package:flutter/material.dart';

class ProductModel {
  final String? id;
  final String title; // product Name
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final String company;
  final double price;
  final double discountedPrice;
  final List<Color?> colors;
  final List<double> sizes;
  final bool isActive;

  ProductModel({
    this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.company,
    required this.price,
    required this.colors,
    required this.sizes,
    this.isActive = true,
    required this.discountedPrice,
  });

  ProductModel copy({
    String? id,
    String? title,
    double? price,
    double? discountedPrice,
    String? description,
    String? company,
    List<double>? sizes,
    List<Color>? colors,
    List<String>? images,
    bool? isActive,
    int? quantity,
    String? category,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        company: company ?? this.company,
        sizes: sizes ?? this.sizes,
        colors: colors ?? this.colors,
        isActive: isActive ?? this.isActive,
        quantity: quantity ?? this.quantity,
        images: images ?? this.images,
        category: category ?? this.category,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  Map<String, dynamic> toJson() => {
        'productID': id,
        'title': title,
        'price': price,
        'description': description,
        'company': company,
        'sizes': sizes,
        'colors': colors,
        'isActive': isActive,
        'quantity': quantity,
        'images': images,
        'category': category,
        'discountedPrice': discountedPrice,
      };

  static ProductModel fromJson(
    Map<String, dynamic> json,
    String productId,
  ) {
    return ProductModel(
      id: productId,
      title: json['title'],
      price: json['price'],
      description: json['description'],
      company: json['company'],
      /*  sizes: json['sizes'],*/
      sizes: (json['sizes'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
/*      colors: json['coors'],*/

      colors: (json['colors'] as List<dynamic>? ?? [])
          .map((e) => e == null ? null : Color(e))
          .toList(),
/*      isActive: json['isActive'],*/
      isActive: json['isActive'] ?? false,
      quantity: json['quantity'],
      /*   images: json['images'],*/
      images: List<String>.from(json['images'] ?? []),
      category: json['category'],
      discountedPrice: json['discountedPrice'],
    );
  }
}
