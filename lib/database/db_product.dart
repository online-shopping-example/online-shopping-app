import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBProduct {
  static CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  // Getting specific Product from FireStore Database.
  static Future<DocumentSnapshot> getDBProduct(String productId) async {
    try {
      DocumentSnapshot doc = await productsCollection.doc(productId).get();
      return doc;
    } catch (e) {
      debugPrint(
          'There was an error with getting the Product from fireStore DataBase $e');
      rethrow;
    }
  }

  // Adding a new Product to the FireStore Database.
  static Future<String> addDBProduct(Map<String, dynamic> addToData) async {
    try {
      DocumentReference productDoc = await productsCollection.add(addToData);
      return productDoc.id;
    } catch (e) {
      debugPrint(
          'There was an error with adding the Product to the fireStore DataBase $e');
      rethrow;
    }
  }

  // Updating the Product in fireStore Database.
  static Future<void> updateDBProduct(
    String productId,
    Map<String, dynamic> updateToData,
  ) async {
    try {
      await productsCollection.doc(productId).update(updateToData);
    } catch (e) {
      debugPrint(
          'There was an error with updating the Product to fireStore DataBase $e');
      rethrow;
    }
  }

  // Deleting the Product from fireStore Database.
  static Future<void> deleteDBProduct(
    String productId,
  ) async {
    try {
      await productsCollection.doc(productId).delete();
    } catch (e) {
      debugPrint(
          'There was an error with deleting the Product from fireStore DataBase $e');
      rethrow;
    }
  }

  // getting all Products from fireStore Database.
  static Future<List<QueryDocumentSnapshot>> getAllDBProducts() async {
    try {
      QuerySnapshot allProductsAsFuture =
          await productsCollection.orderBy('name').snapshots().first;
      List<QueryDocumentSnapshot> listOfProducts = allProductsAsFuture.docs;
      return listOfProducts;
    } catch (e) {
      debugPrint(
          'There was an error with getting all the Products from fireStore DataBase $e');
      rethrow;
    }
  }

  // getting all Products as stream from fireStore Database.
  static Stream<QuerySnapshot> getAllDBProductsAsStream() {
    return productsCollection.orderBy('name').snapshots();
  }
}
