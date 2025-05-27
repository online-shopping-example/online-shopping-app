import 'package:flutter/material.dart';
import 'package:online_shopping_app/admin/screens/products/add_edit_product_view.dart';
import 'package:online_shopping_app/admin/screens/products/product_list_view.dart';
import 'package:online_shopping_app/controllers/product_controller.dart';
import 'package:online_shopping_app/models/product_model.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late Stream<List<ProductModel>> _allProductStream;

  List<ProductModel> _allProducts = [];

  // Switcher between all Schools view and adding / editing a School view
  bool _addEditProduct = false;

  // Placeholder for editing the Product
  ProductModel? _editedProduct;

  // Initialize the scrollbar controller.
  final ScrollController _scrollController = ScrollController();
  double _savedScrollOffset = 0.0; // Save the scroll offset

  @override
  void initState() {
    _allProductStream = ProductController.getAllProductsAsStream();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: _drawAppBar(),
      floatingActionButton: _drawFloatingActionButton(),
      body: _drawBody(),
    );
  }

  AppBar _drawAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      automaticallyImplyLeading: _addEditProduct ? false : true,
      title: const Text(
        'All Products',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  FloatingActionButton? _drawFloatingActionButton() {
    return _addEditProduct
        ? null
        : FloatingActionButton.extended(
            label: const Row(
              children: [
                Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ],
            ),
            backgroundColor: Colors.green,
            onPressed: () {
              setState(() {
                _addEditProduct = true;
              });
            },
          );
  }

  Widget _drawBody() {
    // position the scrollbar correctly.
    _scrollBarPositioning();
    return StreamBuilder<List<ProductModel>>(
      stream: _allProductStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _drawView(snapshot);
        } else if (snapshot.hasError) {
          // Handle error case
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
            ),
          );
        } else {
          // Loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _drawView(AsyncSnapshot<List<ProductModel>> snapshot) {
    // setting the _allSchools correctly
    _allProducts = snapshot.data!;
    // show the right view.
    if (_addEditProduct) {
      return AddEditProductScreen(
          allProducts: _allProducts,
          resetView: () {
            _addEditProduct = false;
            _editedProduct = null;
          });
    } else {
      if (_allProducts.isEmpty) {
        return const Center(
          child: Text('No Products found!'),
        );
      } else {
        return ProductListView(
            allProducts: _allProducts,
            onEdit: (int index) {
              setState(() {
                _addEditProduct = true;
                _editedProduct = _allProducts[index];
              });
            },
            scrollController: _scrollController);
      }
    }
  }

  void _scrollBarPositioning() {
    if (_allProducts.isNotEmpty) {
      if (_addEditProduct) {
        // Save scroll offset before leaving QuestionsListView.
        _savedScrollOffset = _scrollController.offset;
      } else {
        // Restore scroll offset when returning to QuestionsListView.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_savedScrollOffset);
        });
      }
    }
  }
}
