import 'package:flutter/material.dart';
import 'package:online_shopping_app/controllers/category_controller.dart';

import '../../models/category_model.dart';

import '../../controllers/category_controller.dart';
import '../../models/categories_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late Stream<List<CategoriesModel>> _allCategoriesStream;

  @override
  void initState() {
    // TODO: implement initState
    _allCategoriesStream = CategoryController.getAllCategoriesAsStream();
    super.initState();
  }

  late Stream<List<CategoriesModel>> _allCategoriesStream;

  @override
  void initState() {
    // TODO: implement initState
    _allCategoriesStream = CategoryController.getAllCategoriesAsStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Crate Products'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'titl'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
