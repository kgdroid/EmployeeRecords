import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  // New Firestire Collection name EMPLOYEES
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('employees');

  // Create new entry in DATABASE
  Future<DocumentReference<Object?>> createUserData(
      String name, String job, String year, String uid, bool isFive) async {
    return await profileList
        .add({'name': name, 'job': job, 'year': year, 'isFive': isFive});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        for (var element in querySnapshot.docChanges) {
          itemsList.add(element.doc);
        }
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
