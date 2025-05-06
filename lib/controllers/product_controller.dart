import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/database/db_product.dart';
import 'package:online_shopping_app/models/product_model.dart';

class ProductController {
  // getting specific Product.
  static Future<ProductModel?> getProduct(String productId) async {
    try {
      DocumentSnapshot productDoc = await DBProduct.getDBProduct(productId);
      if (productDoc.exists) {
        ProductModel productsModel = ProductModel.fromJson(
            productDoc.data() as Map<String, dynamic>, productId);
        return productsModel;
      }
      return null;
    } catch (e) {
      debugPrint('There was an error with getting the Product $e');
      rethrow;
    }
  }

  // adding  new Product.

  static Future<ProductModel?> addProduct(ProductModel productModel) async {
    try {
      String productID = await DBProduct.addDBProduct(
        productModel.toJson(),
      );
      return productModel.copy(
        id: productID,
      );
    } catch (e) {
      debugPrint(' There was an error with adding the Product $e');
      rethrow;
    }
  }

  // updating  Product.
  static Future<void> updateProduct(ProductModel productsModel) async {
    try {
      await DBProduct.updateDBProduct(
          productsModel.id!, productsModel.toJson());
    } catch (e) {
      debugPrint('There was an error with updating the Product $e');
      rethrow;
    }
  }

  // deleting  Product.
  static Future<void> deleteProduct(ProductModel productsModel) async {
    try {
      await DBProduct.deleteDBProduct(productsModel.id!);
    } catch (e) {
      debugPrint('There was an error with deleting the Product $e');
      rethrow;
    }
  }

  // getting all Products as Future.
  static Future<List<ProductModel>> gettingAllProducts() async {
    try {
      List<QueryDocumentSnapshot> allProductsQuery =
          await DBProduct.getAllDBProducts();
      List<ProductModel> allProducts = [];
      for (QueryDocumentSnapshot productDoc in allProductsQuery) {
        if (productDoc.exists) {
          ProductModel newProductsModel = ProductModel.fromJson(
              productDoc.data() as Map<String, dynamic>, productDoc.id);
          allProducts.add(newProductsModel);
        }
      }
      return allProducts;
    } catch (e) {
      debugPrint('There was an error with getting all the Products  $e');
      rethrow;
    }
  }

// getting all Products as Stream
  static Stream<List<ProductModel>> getAllProductsAsStream() {
    Stream<QuerySnapshot> snapShot = DBProduct.getAllDBProductsAsStream();
    return snapShot.map((snapShot) {
      try {
        List<ProductModel> products = snapShot.docs.map((doc) {
          Map<String, dynamic> dataOfDoc = doc.data() as Map<String, dynamic>;
          return ProductModel.fromJson(dataOfDoc, doc.id);
        }).toList();
        return products;
      } catch (e) {
        debugPrint('Error in conversion: $e');
        rethrow;
      }
    });
  }
}
