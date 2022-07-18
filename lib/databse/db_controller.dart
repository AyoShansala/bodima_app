// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';

// final CollectionReference _allUserData =
//     FirebaseFirestore.instance.collection("AllUserData");
// final CollectionReference _userPayments =
//     FirebaseFirestore.instance.collection("UserPayements");

// class Database {
//   static String? userPhoneNum;

//   static String? get documentId => null;

//   //User Data add.........................................................
//   static Future<void> addItem({
//     required String name,
//     required String address,
//     required String roomNum,
//     required String parentPhoneNum1,
//     required String parentPhonenum2,
//     required String idNum,
//   }) async {
//     // DocumentReference documentReferencer =
//     //     _allUserData.doc(userPhoneNum).collection('items').doc();
//     final _allUserData =
//         FirebaseFirestore.instance.collection("trialData").doc(userPhoneNum);

//     Map<String, dynamic> data = <String, dynamic>{
//       "User_Phone_Number": userPhoneNum,
//       "Name": name,
//       "Address": address,
//       "Room_Number": roomNum,
//       "Parent_Number_1": parentPhoneNum1,
//       "Parent_Number_2": parentPhonenum2,
//       "ID_Number": idNum,
//     };

//     await _allUserData
//         .set(data)
//         .whenComplete(() => print("Note item added to the database"))
//         .catchError((e) => print(e));
//   }

//   //Payment data add............................................................
//   static Future<void> addPayment({
//     required String year,
//     required String month,
//     required String payStatus,
//     required String payFee,
//   }) async {
//     DocumentReference documentReferencer =
//         _userPayments.doc(userPhoneNum).collection('Fee').doc();

//     Map<String, dynamic> data = <String, dynamic>{
//       "User_Phone_Number": userPhoneNum,
//       "Year": year,
//       "Month": month,
//       "Payment_Status": payStatus,
//       "Payment Fee": payFee,
//     };

//     await documentReferencer
//         .set(data)
//         .whenComplete(() => print("Note item added to the database"))
//         .catchError((e) => print(e));
//   }

//   // static Future<void> updateItem({
//   //   required String title,
//   //   required String description,
//   //   required String docId,
//   // }) async {
//   //   DocumentReference documentReferencer =
//   //       _mainCollection.doc(userUid).collection('items').doc(docId);

//   //   Map<String, dynamic> data = <String, dynamic>{
//   //     "title": title,
//   //     "description": description,
//   //   };

//   //   await documentReferencer
//   //       .update(data)
//   //       .whenComplete(() => print("Note item updated in the database"))
//   //       .catchError((e) => print(e));
//   // }

//   //read items for admin dashboard screen
//   static Stream<QuerySnapshot> readDasboardItems() {
//     return FirebaseFirestore.instance
//         .collection("AllUserData")
//         .doc("0788694575")
//         .collection("items")
//         .snapshots();
//   }

//   //read items for user profile screen
//   static Stream<QuerySnapshot> readItems(String phoneNumber) {
//     return FirebaseFirestore.instance
//         .collection("AllUserData")
//         .doc(phoneNumber)
//         .collection("items")
//         .snapshots();
//   }

//   // static Future<void> deleteItem({
//   //   required String docId,
//   // }) async {
//   //   DocumentReference documentReferencer =
//   //       _mainCollection.doc(userUid).collection('items').doc(docId);

//   //   await documentReferencer
//   //       .delete()
//   //       .whenComplete(() => print('Note item deleted from the database'))
//   //       .catchError((e) => print(e));
//   // }
// }
