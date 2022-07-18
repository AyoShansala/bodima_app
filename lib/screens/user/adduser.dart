// import 'package:bording_login_ui/screens/user/userpayement.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class UserDetailScreeen extends StatefulWidget {
//   const UserDetailScreeen({
//     Key? key,
//     required this.userUID,
//     required this.userPhoneNum,
//   }) : super(key: key);
//   final String userUID;
//   final String userPhoneNum;

//   @override
//   _UserDetailScreeenState createState() => _UserDetailScreeenState();
// }

// class _UserDetailScreeenState extends State<UserDetailScreeen> {
//   // text fields' controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _roomNumberController = TextEditingController();
//   final TextEditingController _parentPhoneNumberController =
//       TextEditingController();
//   final TextEditingController _IdNumberController = TextEditingController();
//   final _users = FirebaseFirestore.instance.collection('Users');

//   // This function is triggered when the floatting button or one of the edit buttons is pressed
//   // Adding a product if no documentSnapshot is passed
//   // If documentSnapshot != null then update an existing product
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _nameController.text = documentSnapshot['name'];
//       _addressController.text = documentSnapshot['address'];
//       _roomNumberController.text = documentSnapshot['roomNumber'].toString();
//       _parentPhoneNumberController.text =
//           documentSnapshot['parentPhoneNumber'].toString();
//       _IdNumberController.text = documentSnapshot['IdNumber'].toString();
//     }

//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//               top: 20,
//               left: 20,
//               right: 20,
//               // // prevent the soft keyboard from covering text fields
//               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(labelText: 'Name'),
//                   ),
//                   TextField(
//                     controller: _addressController,
//                     decoration: const InputDecoration(labelText: 'Address'),
//                   ),
//                   TextField(
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     controller: _roomNumberController,
//                     decoration: const InputDecoration(
//                       labelText: 'Room Number',
//                     ),
//                   ),
//                   TextField(
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     controller: _parentPhoneNumberController,
//                     decoration: const InputDecoration(
//                       labelText: 'Parent Phone Number',
//                     ),
//                   ),
//                   TextField(
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     controller: _IdNumberController,
//                     decoration: const InputDecoration(
//                       labelText: 'Id Number',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     child: Text(action == 'create' ? 'Create' : 'Update'),
//                     onPressed: () async {
//                       final String? name = _nameController.text;
//                       final String? address = _addressController.text;
//                       final double? roomNumber =
//                           double.tryParse(_roomNumberController.text);
//                       final double? parentNumber =
//                           double.tryParse(_parentPhoneNumberController.text);
//                       final double? IdNumber =
//                           double.tryParse(_IdNumberController.text);
//                       if (name != null &&
//                           address != null &&
//                           roomNumber != null &&
//                           parentNumber != null &&
//                           IdNumber != null) {
//                         if (action == 'create') {
//                           // Persist a new product to Firestore
//                           await _users.add({
//                             "User_Phone_Number": widget.userPhoneNum,
//                             "name": name,
//                             "address": address,
//                             "roomNumber": roomNumber,
//                             "parentPhoneNumber": parentNumber,
//                             "IdNumber": IdNumber
//                           });
//                         }

//                         if (action == 'update') {
//                           // Update the product
//                           await _users.doc(documentSnapshot!.id).update({
//                             "name": name,
//                             "address": address,
//                             "roomNumber": roomNumber,
//                             "parentPhoneNumber": parentNumber,
//                             "IdNumber": IdNumber
//                           });
//                         }

//                         // Clear the text fields
//                         _nameController.text = '';
//                         _addressController.text = '';
//                         _roomNumberController.text = '';
//                         _parentPhoneNumberController.text = '';
//                         _IdNumberController.text = '';

//                         // Hide the bottom sheet
//                         Navigator.of(context).pop();
//                       }
//                     },
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   // Deleteing a product by id
//   Future<void> _deleteProduct(String productId) async {
//     await _users.doc(productId).delete();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('You have successfully deleted a User')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.green,
//         title: const Text('User Details'),
//         leading: Icon(Icons.account_circle_rounded),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _users.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Future.delayed(Duration(seconds: 20), () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserPaymentScreeen(
//                             userPhoneNum: widget.userPhoneNum,
//                             userUID: widget.userUID,
//                           ),
//                         ),
//                       );
//                     });
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.all(10),
//                     child: ListTile(
//                       title: Text(documentSnapshot['name'],
//                           style: const TextStyle(fontSize: 30)),
//                       subtitle: Text(documentSnapshot['address']),
//                       trailing: SizedBox(
//                         width: 100,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               ButtonBar(
//                                 children: [
//                                   IconButton(
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         color: Colors.blue,
//                                       ),
//                                       onPressed: () =>
//                                           _createOrUpdate(documentSnapshot)),
//                                   // This icon button is used to delete a single product
//                                   IconButton(
//                                       icon: const Icon(Icons.delete,
//                                           color: Colors.red),
//                                       onPressed: () =>
//                                           _deleteProduct(documentSnapshot.id)),

//                                   IconButton(
//                                       icon: const Icon(Icons.add_circle,
//                                           color: Colors.red),
//                                       onPressed: () => {
//                                             UserPaymentScreeen(
//                                               userPhoneNum: widget.userPhoneNum,
//                                               userUID: widget.userUID,
//                                             ),
//                                           })
//                                 ],
//                               ),
//                               // Press this button to edit a single product
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),

//       // Add new product
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         onPressed: () => _createOrUpdate(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
