import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String fullName;
  final String email;
  final String uid;
  final String phoneNumber;
  String title;

  DatabaseService(this.fullName, this.email, this.uid, this.phoneNumber);

  CollectionReference staff = FirebaseFirestore.instance.collection('Staff');

  Future<void> addStaff() {
    return staff
        .doc(uid)
        .set({
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'email': email,
          'title': 'garson',
        })
        .then((value) => print("Staff Added"))
        .catchError((error) => print("Failed to add staff: $error"));
  }
}
