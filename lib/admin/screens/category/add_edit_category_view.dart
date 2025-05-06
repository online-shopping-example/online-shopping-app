import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_shopping_app/components/error_diaglog.dart';
import 'package:online_shopping_app/components/primary_button_widget.dart';
import 'package:online_shopping_app/components/primary_text_form_field_widget.dart';
import 'package:online_shopping_app/components/warning_diaglog.dart';
import 'package:online_shopping_app/models/categories_model.dart';
import 'package:uiblock/uiblock.dart';

import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';

class AddEditCategoryView extends StatefulWidget {
  final CategoryModel? currentCategory;
  final List<CategoryModel> allCategories;
  final void Function() resetView;

  const AddEditCategoryView({
    super.key,
    this.currentCategory,
    required this.allCategories,
    required this.resetView,
  });

  @override
  State<AddEditCategoryView> createState() => _AddEditCategoryViewState();
}

class _AddEditCategoryViewState extends State<AddEditCategoryView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _controllerName;
  TextEditingController? _controllerImageUrl;
  File? _imageFile;
  String? _uploadedImageUrl;
  dynamic remoteFiles;

  @override
  void initState() {
    // TODO: implement initState
    _controllerImageUrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentCategory != null) {
      _controllerName ??=
          TextEditingController(text: widget.currentCategory!.name);
    } else {
      _controllerName ??= TextEditingController();
    }
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryTextFormFieldWidget(
              controller: _controllerName!,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Category name';
                }
                return null;
              },
              labelText: 'Please add the category name',
            ),
            const SizedBox(
              height: 30.0,
            ),
            PrimaryTextFormFieldWidget(
              controller: _controllerImageUrl!,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please loading the Category ImageUrl';
                }
                return null;
              },
              labelText: 'Please add the category ImageUrl',
            ),
            SizedBox(height: 20.0),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  PrimaryButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _addOrEditCategory();
                      }
                    },
                    buttonText: widget.currentCategory != null
                        ? 'Edit Category'
                        : 'Add category',
                    textColor: Colors.green,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  widget.currentCategory != null
                      ? PrimaryButtonWidget(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext contxt) {
                                return WarningDialog(
                                  title: 'Delete category',
                                  message:
                                      'Do you really want to delete this category ?',
                                  firstEventTerm: 'Delete Category',
                                  secondEventTerm: 'Keep Category',
                                  firstEventFunction: () async {
                                    Navigator.of(context).pop();
                                    await _deleteCategory(
                                        widget.currentCategory!);
                                  },
                                  secondEventFunction: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          buttonText: 'Delete Category',
                          textColor: Colors.red,
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// ************************************************** Functions ***************************************************** //

  Future<void> _addOrEditCategory() async {
    try {
      UIBlock.block(context);

      String? imageUrl;

      // Upload the image if present
      if (remoteFiles != null && remoteFiles!.isNotEmpty) {
      } else {
        imageUrl =
            _controllerImageUrl!.text.trim(); // fallback if manually entered
      }

      if (widget.currentCategory == null) {
        CategoryModel newCategory = CategoryModel(
          name: _controllerName!.text.trim(),
          /*     imageUrl: _controllerImageUrl!.text.trim(),*/
          imageUrl: _controllerImageUrl!.text.trim(),
        );
        await CategoryController.addCategory(newCategory as CategoriesModel);
      } else {
        CategoryModel categoryModel = widget.currentCategory!.copy(
          name: _controllerName!.text.trim(),
        );
        widget.currentCategory!.copy(
          imageUrl: imageUrl!,
        );
        await CategoryController.updateCategory(
            categoryModel as CategoriesModel);
      }

      if (!context.mounted) return;
      UIBlock.unblock(context);
    } catch (e) {
      debugPrint('Error $e');

      if (!context.mounted) return;
      UIBlock.unblock(context);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            title: widget.currentCategory == null
                ? 'Error adding new category'
                : 'Error updating category',
            message: widget.currentCategory == null
                ? 'The category could not be added. The error message was: $e'
                : 'The category could not be updated. The error message was: $e',
            firstEventTerm: 'Try Again',
            secondEventTerm: 'Okay',
            firstEventFunction: () async {
              Navigator.of(context).pop();
            },
            secondEventFunction: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }

  // Delete category

  Future<void> _deleteCategory(CategoryModel categoryModel) async {
    bool categoryDeleted = false;
    try {
      UIBlock.block(context);

      CategoryController.deleteCategory(categoryModel as CategoriesModel);

      if (!context.mounted) return;
      UIBlock.unblock(context);
      if (categoryDeleted == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The category was deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (!context.mounted) return;
      UIBlock.unblock(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            title: 'Error deleting subject',
            message:
                'The subject could not be deleted. The error message was: $e',
            firstEventTerm: 'Try Again',
            secondEventTerm: 'Okay',
            firstEventFunction: () async {
              Navigator.of(context).pop();
              await _deleteCategory(categoryModel);
            },
            secondEventFunction: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }
}
