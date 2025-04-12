import 'package:flutter/material.dart';
import 'package:online_shopping_app/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // is Product Active or it is not
  bool _isActive = false;

  ProductModel? productModel;

  List<ProductModel> allProducts = [];

  void isProductActive(bool value) {
    setState(() {
      _isActive = value;
    });
  }

  void isProductNotActive(bool value) {
    setState(() {
      _isActive = value;
    });
  }

  int x = 0;

  void increment() {
    setState(() {
      if (x == x) {
        x++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (x > 0) {
        x--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Create Product'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 400,
                  height: 100,
                  child: TextFormField(
                    readOnly: false,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                ),
                const SizedBox(height: 50.0),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: TextFormField(
                    readOnly: false,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: TextFormField(
                    readOnly: false,
                    decoration: const InputDecoration(
                      labelText: 'discountedPrice',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const Text('is Product Active :'),
                    Expanded(
                      child: SwitchListTile(
                        subtitle: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '$_isActive',
                            style: TextStyle(
                                color: _isActive == true
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                        inactiveThumbColor:
                            _isActive == true ? Colors.green : Colors.red,
                        activeColor:
                            _isActive == true ? Colors.green : Colors.red,
                        value: _isActive,
                        onChanged: (value) {
                          if (value == true) {
                            isProductActive(value);
                          } else {
                            isProductNotActive(value);
                          }
                          debugPrint(_isActive.toString());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    const Text('add Quantity :'),
                    const SizedBox(width: 20.0),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: TextFormField(
                        readOnly: false,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    increment();
                  },
                  child: const Text('increment'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text('$x'),
                TextButton(
                  onPressed: () {
                    decrement();
                  },
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
