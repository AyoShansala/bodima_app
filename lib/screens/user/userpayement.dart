// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class UserPaymentScreeen extends StatefulWidget {
//   const UserPaymentScreeen({
//     Key? key,
//     required this.userUID,
//     required this.userPhoneNum,
//   }) : super(key: key);
//   final String userUID;
//   final String userPhoneNum;

//   @override
//   _UserPaymentScreeenState createState() => _UserPaymentScreeenState();
// }

// class _UserPaymentScreeenState extends State<UserPaymentScreeen> {
//   // text fields' controllers
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _paymentController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final CollectionReference _users =
//       FirebaseFirestore.instance.collection('Users');
//   final CollectionReference _UserPayments =
//       FirebaseFirestore.instance.collection("UserPayements");

//   // This function is triggered when the floatting button or one of the edit buttons is pressed
//   // Adding a product if no documentSnapshot is passed
//   // If documentSnapshot != null then update an existing product
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _dateController.text = documentSnapshot['date'];
//       _paymentController.text = documentSnapshot['payment'].toString();
//       _statusController.text = documentSnapshot['status'].toString();
//       _descriptionController.text = documentSnapshot['parentPhoneNumber'];
//     }
//     DocumentReference userInfoDocumentReference =
//         _users.doc(widget.userPhoneNum).collection("UserInfo").doc();
//     DocumentReference userPayemntsDocumentReference =
//         _UserPayments.doc(widget.userPhoneNum).collection("Payements").doc();

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
//                     controller: _dateController,
//                     decoration:
//                         const InputDecoration(labelText: 'Date :yyyy/mm/dd'),
//                   ),
//                   TextField(
//                     controller: _paymentController,
//                     decoration: const InputDecoration(labelText: 'payment'),
//                   ),
//                   TextField(
//                     controller: _statusController,
//                     decoration: const InputDecoration(
//                       labelText: 'status',
//                     ),
//                   ),
//                   TextField(
//                     controller: _descriptionController,
//                     decoration: const InputDecoration(
//                       labelText: 'description',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     child: Text(action == 'create' ? 'Create' : 'Update'),
//                     onPressed: () async {
//                       final String? date = _dateController.text;
//                       final String? payment = _paymentController.text;
//                       final bool? status =
//                           _statusController.text == 'true' ? true : false;
//                       final String? description = _descriptionController.text;

//                       if (date != null &&
//                           payment != null &&
//                           status != null &&
//                           description != null) {
//                         if (action == 'create') {
//                           // Persist a new product to Firestore
//                           await _UserPayments.add({
//                             "date": date,
//                             "payment": payment,
//                             "status": status,
//                             "description": description,
//                             "User_Phonne_Number": widget.userPhoneNum,
//                           });
//                         }

//                         if (action == 'update') {
//                           // Update the product
//                           await _UserPayments.doc(documentSnapshot!.id).update({
//                             "date": date,
//                             "payment": payment,
//                             "status": status,
//                             "description": description,
//                           });
//                         }

//                         // Clear the text fields
//                         _dateController.text = '';
//                         _paymentController.text = '';
//                         _statusController.text = '';
//                         _descriptionController.text = '';

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
//         title: const Text('User payment Details'),
//         leading: Icon(Icons.account_circle_rounded),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _UserPayments.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name'],
//                         style: const TextStyle(fontSize: 30)),
//                     subtitle: Text(documentSnapshot['payment']),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             ButtonBar(
//                               children: [
//                                 IconButton(
//                                     icon: const Icon(
//                                       Icons.edit,
//                                       color: Colors.blue,
//                                     ),
//                                     onPressed: () =>
//                                         _createOrUpdate(documentSnapshot)),
//                                 // This icon button is used to delete a single product
//                                 IconButton(
//                                     icon: const Icon(Icons.delete,
//                                         color: Colors.red),
//                                     onPressed: () =>
//                                         _deleteProduct(documentSnapshot.id)),
//                               ],
//                             ),
//                             // Press this button to edit a single product
//                           ],
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
//         onPressed: () {
//           _createOrUpdate();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
