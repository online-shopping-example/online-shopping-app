import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/database/dp_category.dart';
import 'package:online_shopping_app/models/category_model.dart';

class CategoryController {
  // getting specific category.
  static Future<CategoryModel?> getCategory(String categoryId) async {
    try {
      DocumentSnapshot categoryDoc = await DBCategory.getDBCategory(categoryId);
      if (categoryDoc.exists) {
        CategoryModel categoryModel = CategoryModel.fromJson(
            categoryDoc.data() as Map<String, dynamic>, categoryId);
        return categoryModel;
      }
      return null;
    } catch (e) {
      debugPrint('There was an error with getting the category $e');
      rethrow;
    }
  }

  // adding a new category.
  static Future<CategoryModel?> addCategory(
      CategoryModel categoriesModel) async {
    try {
      String categoryID = await DBCategory.addDBCategory(
        categoriesModel.toJson(),
      );
      return categoriesModel.copy(id: categoryID);
    } catch (e) {
      debugPrint('There was an error with adding the category $e');
      rethrow;
    }
  }

// updating a category.
  static Future<void> updateCategory(CategoryModel categoriesModel) async {
    try {
      await DBCategory.updateDBCategory(
          categoriesModel.id!, categoriesModel.toJson());
    } catch (e) {
      debugPrint('There was an error with updating the category $e');
      rethrow;
    }
  }

// deleting a category.
  static Future<void> deleteCategory(CategoryModel categoriesModel) async {
    try {
      await DBCategory.deleteDBCategory(categoriesModel.id!);
    } catch (e) {
      debugPrint('There was an error with deleting the category $e');
      rethrow;
    }
  }

// getting all categories as Future.
  static Future<List<CategoryModel>> gettingAllCategories() async {
    try {
      List<QueryDocumentSnapshot> allCategoriesQuery =
          await DBCategory.getAllDBCategories();
      List<CategoryModel> allCategories = [];
      for (QueryDocumentSnapshot categoryDoc in allCategoriesQuery) {
        if (categoryDoc.exists) {
          CategoryModel newCategoriesModel = CategoryModel.fromJson(
              categoryDoc.data() as Map<String, dynamic>, categoryDoc.id);
          allCategories.add(newCategoriesModel);
        }
      }
      return allCategories;
    } catch (e) {
      debugPrint('There was an error with getting all the category  $e');
      rethrow;
    }
  }

  // getting all categories as Stream
  static Stream<List<CategoryModel>> getAllCategoriesAsStream() {
    Stream<QuerySnapshot> snapShot = DBCategory.getAllDBCategoriesAsStream();
    return snapShot.map((snapShot) {
      try {
        List<CategoryModel> categories = snapShot.docs.map((doc) {
          Map<String, dynamic> dataOfDoc = doc.data() as Map<String, dynamic>;
          return CategoryModel.fromJson(dataOfDoc, doc.id);
        }).toList();
        return categories;
      } catch (e) {
        debugPrint('Error in conversion: $e');
        rethrow;
      }
    });
  }
}
