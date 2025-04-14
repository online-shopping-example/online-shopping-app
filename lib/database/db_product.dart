import 'package:cloud_firestore/cloud_firestore.dart';

class DBProduct {
  static CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('category');
}
