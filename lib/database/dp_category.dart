import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DBCategory {
  static CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('category');

// Getting specific category from FireStore Database.
  static Future<DocumentSnapshot> getDBCategory(String categoryId) async {
    try {
      DocumentSnapshot doc = await categoriesCollection.doc(categoryId).get();
      return doc;
    } catch (e) {
      debugPrint(
          'There was an error with getting the category from fireStore DataBase $e');
      rethrow;
    }
  }

  // Adding a new category to the FireStore Database.
  static Future<String> addDBCategory(Map<String, dynamic> addToData) async {
    try {
      DocumentReference categoryDoc = await categoriesCollection.add(addToData);
      return categoryDoc.id;
    } catch (e) {
      debugPrint(
          'There was an error with adding the category to the fireStore DataBase $e');
      rethrow;
    }
  }

  // Updating the category in fireStore Database.
  static Future<void> updateDBCategory(
      String categoryId, Map<String, dynamic> updateToData) async {
    try {
      await categoriesCollection.doc(categoryId).update(updateToData);
    } catch (e) {
      debugPrint(
          'There was an error with updating the category to fireStore DataBase $e');
      rethrow;
    }
  }

  // Deleting the category from fireStore Database.
  static Future<void> deleteDBCategory(String categoryID) async {
    try {
      await categoriesCollection.doc(categoryID).delete();
    } catch (e) {
      debugPrint(
          'There was an error with deleting the category from fireStore DataBase $e');
      rethrow;
    }
  }

//getting all categories from fireStore Database.
  static Future<List<QueryDocumentSnapshot>> getAllDBCategories() async {
    try {
      QuerySnapshot allCategoriesAsFuture =
          await categoriesCollection.orderBy('name').snapshots().first;
      List<QueryDocumentSnapshot> listOfCategories = allCategoriesAsFuture.docs;
      return listOfCategories;
    } catch (e) {
      debugPrint(
          'There was an error with getting all the categories from fireStore DataBase $e');
      rethrow;
    }
  }

//getting all categories as stream from fireStore Database.
  static Stream<QuerySnapshot> getAllDBCategoriesAsStream() {
    return categoriesCollection.orderBy('name').snapshots();
  }
}
