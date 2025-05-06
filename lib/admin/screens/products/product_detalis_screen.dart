import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import 'add_edit_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${product!.title}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Description: ${product!.description}"),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Edit"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditProductScreen(
                      allProducts: [],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
