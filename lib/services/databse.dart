import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final DatabaseReference userData = FirebaseDatabase.instance.ref('userData');

  Future upDateUserData(
    String email,
    String phoneNumber,
  ) async {
    return await userData.child(uid).set({
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }
}
