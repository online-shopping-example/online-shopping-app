import 'package:flutter/material.dart';
import 'package:online_shopping_app/controllers/product_controller.dart';
import 'package:uiblock/uiblock.dart';

import '../../../models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final ProductModel? currentProduct;
  final List<ProductModel> allProducts;

  const AddEditProductScreen({
    super.key,
    this.currentProduct,
    required this.allProducts,
  });

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _quantityController;
  TextEditingController? _categoryController;
  TextEditingController? _companyController;
  TextEditingController? _priceController;
  TextEditingController? _discountedPriceController;
  TextEditingController? _imagesController;
  bool isActive = true;

  // ***********************************  Functions ************************************ //

  // **************** Adding new Product and update the Product ****************** //
  Future<void> _addProduct() async {
    try {
      UIBlock.block(context);
      if (widget.currentProduct == null) {
        ProductModel productModel = ProductModel(
          title: _titleController!.text.trim(),
          description: _descriptionController!.text.trim(),
          quantity: int.parse(_quantityController!.text.trim()).abs(),
          images: [],
          category: _categoryController!.text.trim(),
          company: _companyController!.text.trim(),
          price: double.parse(_priceController!.text.trim()).abs(),
          colors: [],
          sizes: [],
          isActive: isActive ?? false,
          discountedPrice:
              double.parse(_discountedPriceController!.text.trim()),
        );
        await ProductController.addProduct(productModel);
      } else {
        ProductModel? productModelID = widget.currentProduct;
        productModelID!.id;
        await ProductController.updateProduct(productModelID);
      }
      if (!context.mounted) return;
      UIBlock.unblock(context);
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  // ******************* Delete Product ********************* //

  Future<void> _deleteProduct(ProductModel productModel) async {
    bool productDeleted = false;
    try {
      UIBlock.block(context);

      await ProductController.deleteProduct(productModel);
      if (!context.mounted) return;
      UIBlock.unblock(context);

      if (productDeleted == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The Product has been deleted Successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  // ************************************** Build Widget  ************************************** //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
