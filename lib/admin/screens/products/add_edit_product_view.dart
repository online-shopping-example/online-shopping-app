import 'package:flutter/material.dart';
import 'package:online_shopping_app/controllers/product_controller.dart';
import 'package:uiblock/uiblock.dart';

import '../../../components/error_dialog.dart';
import '../../../components/primary_button_widget.dart';
import '../../../components/primary_switcher_widget.dart';
import '../../../components/primary_text_form_field_widget.dart';
import '../../../components/warning_dialog.dart';
import '../../../models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final ProductModel? currentProduct;
  final List<ProductModel> allProducts;
  final void Function() resetView;

  const AddEditProductScreen({
    super.key,
    this.currentProduct,
    required this.allProducts,
    required this.resetView,
  });

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  // Form global Key for the validation.
  final _formKey = GlobalKey<FormState>();

  // Text controllers.
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _quantityController;
  TextEditingController? _categoryController;
  TextEditingController? _companyController;
  TextEditingController? _priceController;
  TextEditingController? _discountedPriceController;
  TextEditingController? _imagesController;
  bool? _productStatus;

  @override
  void initState() {
    _titleController =
        TextEditingController(text: widget.currentProduct?.title);
    _descriptionController =
        TextEditingController(text: widget.currentProduct?.description);
    _quantityController =
        TextEditingController(text: widget.currentProduct?.quantity.toString());
    _categoryController =
        TextEditingController(text: widget.currentProduct?.category);
    _companyController =
        TextEditingController(text: widget.currentProduct?.company);
    _priceController =
        TextEditingController(text: widget.currentProduct?.price.toString());
    _discountedPriceController = TextEditingController(
        text: widget.currentProduct?.discountedPrice.toString());
    _imagesController = TextEditingController(
        text: widget.currentProduct?.images.toList().toString());
    _productStatus =
        widget.currentProduct != null ? widget.currentProduct!.isActive : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          _drawButtonsSection(),
          const SizedBox(height: 30.0),
          _drawStatus(),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _drawTextFieldsColumn(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawButtonsSection() {
    return Row(
      children: [
        PrimaryButtonWidget(
          onPressed: () async {
            await _cancelView();
          },
          buttonText: 'Cancel',
          textColor: Colors.red,
        ),
        const SizedBox(
          width: 10,
        ),
        widget.currentProduct != null
            ? PrimaryButtonWidget(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WarningDialog(
                        title: 'Delete Product',
                        message: 'Do you really want to delete this Product?',
                        firstEventTerm: 'Delete Product',
                        secondEventTerm: 'Keep Product',
                        firstEventColor: Colors.red,
                        secondEventColor: Colors.green,
                        firstEventFunction: () async {
                          Navigator.of(context).pop();
                          await _deleteProduct();
                        },
                        secondEventFunction: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                buttonText: 'Delete Product',
                textColor: Colors.red,
              )
            : Container(),
        const SizedBox(
          width: 10.0,
        ),
        PrimaryButtonWidget(
          onPressed: () async {
            await _addOrEditProduct();
          },
          buttonText: 'Save changes',
          textColor: Colors.green,
        ),
      ],
    );
  }

  Widget _drawStatus() {
    return PrimarySwitcherWidget(
      onText: 'active',
      offText: 'inactive',
      onOffStatus: _productStatus!,
      onSwitch: (value) {
        setState(() {
          _productStatus = value;
        });
      },
    );
  }

  List<Widget> _drawTextFieldsColumn() {
    // creating the list of children.
    List<Widget> textFields = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'Product name',
          controller: _titleController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the Product name';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'Product Desc',
          controller: _descriptionController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the desc of the Product';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'Quantity',
          controller: _quantityController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the Quantity of the product';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'Category',
          controller: _categoryController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the Category';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'company',
          controller: _companyController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the Company';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'Main Price',
          controller: _priceController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the Main Price';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryTextFormFieldWidget(
          labelText: 'DiscountedPrice',
          controller: _discountedPriceController!,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please add the DiscountedPrice';
            }
            return null;
          },
        ),
      )
    ];
    return textFields;
  }

// ****************************************  Functions *************************************** //
  // Add or Update Product
  Future<void> _addOrEditProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_hasChanges()) {
        try {
          UIBlock.block(context);
          // 1. Creating a product model.
          ProductModel productModel = ProductModel(
            id: widget.currentProduct?.id,
            title: _titleController!.text.trim(),
            description: _descriptionController!.text.trim(),
            quantity: int.parse(_quantityController!.text.trim()),
            images: [],
            category: _categoryController!.text.trim(),
            company: _companyController!.text.trim(),
            price: double.parse(_priceController!.text.trim()),
            colors: [],
            sizes: [],
            discountedPrice:
                double.parse(_discountedPriceController!.text.trim()),
          );
          // 2. Adding product in DB.
          if (widget.currentProduct == null) {
            await ProductController.addProduct(productModel);
          } else {
            // 3. Updating the Existing Product in DB.

            await ProductController.updateProduct(productModel);
          }
          UIBlock.unblock(context);

          // resetting view
          widget.resetView();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The Product was added successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          debugPrint('Error: $e');
          if (!context.mounted) return;
          UIBlock.unblock(context);
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                title: widget.currentProduct == null
                    ? 'Error adding new Product'
                    : 'Error updating Product',
                message: widget.currentProduct == null
                    ? 'The Product could not be added. The error message was: $e'
                    : 'The Product could not be updated. The error message was: $e',
                firstEventTerm: 'Try Again',
                secondEventTerm: 'Okay',
                firstEventFunction: () async {
                  Navigator.of(context).pop();
                  await _addOrEditProduct();
                },
                secondEventFunction: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Changes have been made'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No enough information for the school has been given.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Delete Product

  Future<void> _deleteProduct() async {
    try {
      UIBlock.block(context);

      await ProductController.deleteProduct(widget.currentProduct!.id!);
      if (!context.mounted) return;
      UIBlock.unblock(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The Product was deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // reset view.
      widget.resetView();
    } catch (e) {
      debugPrint('Error: $e');
      if (!context.mounted) return;
      UIBlock.unblock(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            title: 'Error deleting Product',
            message:
                'The school could not be deleted. The error message was: $e',
            firstEventTerm: 'Try Again',
            secondEventTerm: 'Okay',
            firstEventFunction: () async {
              Navigator.of(context).pop();
              await _deleteProduct();
            },
            secondEventFunction: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }

  Future<void> _cancelView() async {
    // Checking if there are Changes.
    if (_hasChanges()) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            title: 'Save changes',
            message: 'Do you really want to cancel before saving your changes?',
            firstEventTerm: 'cancel without saving',
            secondEventTerm: 'Save changes',
            firstEventColor: Colors.red,
            secondEventColor: Colors.green,
            firstEventFunction: () {
              Navigator.of(context).pop();
              // Resenting view
              widget.resetView();
            },
            secondEventFunction: () async {
              Navigator.of(context).pop();
              await _addOrEditProduct();
            },
          );
        },
      );
    } else {
      // Resenting view
      widget.resetView();
    }
  }

  bool _hasChanges() {
    if (widget.currentProduct == null) {
      // Adding new Product.
      if (_titleController!.text.isNotEmpty ||
          _descriptionController!.text.isNotEmpty ||
          _quantityController!.text.isNotEmpty ||
          _categoryController!.text.isNotEmpty ||
          _companyController!.text.isNotEmpty ||
          _priceController!.text.isNotEmpty ||
          _discountedPriceController!.text.isNotEmpty ||
          _productStatus == false) {
        return true;
      }
      return false;
    } else {
      // Editing Product.

      if (widget.currentProduct!.title != _titleController!.text.trim() ||
          widget.currentProduct!.description !=
              _descriptionController!.text.trim() ||
          widget.currentProduct!.quantity !=
              _quantityController!.text.toString().trim() ||
          widget.currentProduct!.category != _categoryController!.text.trim() ||
          widget.currentProduct!.company != _companyController!.text.trim() ||
          /*      widget.currentProduct!.price !=
              _priceController!.text.toString().trim() ||*/
          widget.currentProduct!.discountedPrice !=
              _discountedPriceController!.text.toString().trim() ||
          widget.currentProduct!.isActive != _productStatus) {
        return true;
      }
    }
    return false;
  }
}
