import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseStock {
  final String uuid;
  final int currentQuantity;
  final int increaseNumber;

  DatabaseStock(this.uuid, this.currentQuantity, this.increaseNumber);

  CollectionReference stock = FirebaseFirestore.instance.collection('Stock');

  Future<void> updateStock() {
    return stock
        .doc(uuid)
        .update({'quantity': currentQuantity + increaseNumber})
        .then((value) => print("Stok eklendi"))
        .catchError((error) => print("Failed to update stock: $error"));
  }
}
