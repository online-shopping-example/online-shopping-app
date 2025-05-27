import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_app/components/error_dialog.dart';
import 'package:online_shopping_app/components/primary_button_widget.dart';
import 'package:online_shopping_app/components/primary_text_form_field_widget.dart';
import 'package:uiblock/uiblock.dart';

import '../../../components/warning_dialog.dart';
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

  final ImagePicker _picker = ImagePicker();
  String? imageUrl;

  @override
  void initState() {
    // Setting parameters
    _controllerName = TextEditingController(text: widget.currentCategory?.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          _drawButtonsSection(),
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: 400,
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
                            labelText: 'Please add the category Name',
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: pickAndUploadImage,
                            child: Text('Add image'),
                          ),
                        ],
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
        widget.currentCategory != null
            ? PrimaryButtonWidget(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WarningDialog(
                        title: 'Delete Category',
                        message: 'Do you really want to delete this category?',
                        firstEventTerm: 'Delete Category',
                        secondEventTerm: 'Keep Category',
                        firstEventColor: Colors.red,
                        secondEventColor: Colors.green,
                        firstEventFunction: () async {
                          Navigator.of(context).pop();
                          await _deleteCategory();
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
        const SizedBox(
          width: 10.0,
        ),
        PrimaryButtonWidget(
          onPressed: () async {
            await _addOrEditCategory();
          },
          buttonText: 'Save changes',
          textColor: Colors.green,
        ),
      ],
    );
  }

// ************************************************** Functions ***************************************************** //

  // Upload Image of the Category

  Future<void> pickAndUploadImage() async {
    // Pick file
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String fileName = (file.path);

      try {
        // Upload to Firebase Storage
        final ref = FirebaseStorage.instance.ref().child('images/$fileName');
        await ref.putFile(file);

        // Get download URL
        String downloadURL = await ref.getDownloadURL();
        print('Download URL: $downloadURL');

        // Optional: Save URL to Firestore
        // await FirebaseFirestore.instance.collection('images').add({
        //   'url': downloadURL,
        //   'created_at': FieldValue.serverTimestamp(),
        // });
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      print('No file selected.');
    }
  }

  // Adding or Update Category

  Future<void> _addOrEditCategory() async {
    if (_formKey.currentState!.validate()) {
      if (_hasChanges()) {
        try {
          UIBlock.block(context);
          // 1. Creating a school model.
          CategoryModel categoryModel = CategoryModel(
            id: widget.currentCategory?.id,
            name: _controllerName!.text.trim(),
            imageUrl: '',
          );
          // 2. Adding or updating in DB.
          if (widget.currentCategory == null) // Adding new Category.
          {
            await CategoryController.addCategory(categoryModel);
          } else // Updating an existing Category.
          {
            await CategoryController.updateCategory(categoryModel);
          }
          UIBlock.unblock(context);
          // resetting view.
          widget.resetView();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The Category was added successfully'),
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
                title: widget.currentCategory == null
                    ? 'Error adding new Cate'
                    : 'Error updating school',
                message: widget.currentCategory == null
                    ? 'The Category could not be added. The error message was: $e'
                    : 'The school could not be updated. The error message was: $e',
                firstEventTerm: 'Try Again',
                secondEventTerm: 'Okay',
                firstEventFunction: () async {
                  Navigator.of(context).pop();
                  await _addOrEditCategory();
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

  // Delete category

  Future<void> _deleteCategory() async {
    try {
      UIBlock.block(context);

      CategoryController.deleteCategory(widget.currentCategory!.id!);

      if (!context.mounted) return;
      UIBlock.unblock(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The category was deleted successfully'),
        backgroundColor: Colors.green,
      ));
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
              await _deleteCategory();
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
              await _addOrEditCategory();
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
    if (widget.currentCategory == null) {
      if (_controllerName!.text.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (widget.currentCategory!.name != _controllerName!.text.trim()) {
        return true;
      }
    }
    return false;
  }
}
