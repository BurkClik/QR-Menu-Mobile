import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOrder {
  final String status;

  DatabaseOrder(this.status);

  CollectionReference order = FirebaseFirestore.instance.collection('Orders');

  Future<void> updateOrder(String documentID) {
    return order
        .doc(documentID)
        .update({'status': status})
        .then((value) => print('Order updated'))
        .catchError((error) => print('$error'));
  }
}
