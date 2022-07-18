import 'package:bording_login_ui/screens/admin_screens/payment_more_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../user_screens/add_payment.dart';

class PaidMonths extends StatefulWidget {
  const PaidMonths({
    Key? key,
    required this.userUID,
    required this.userPhoneNum,
  }) : super(key: key);
  final String userUID;
  final String userPhoneNum;

  @override
  State<PaidMonths> createState() => _PaidMonthsState();
}

class _PaidMonthsState extends State<PaidMonths> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        leading: const IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        title: const Text("PAID MONTHS"), // Title............
        centerTitle: true,
      ),
      body: StreamBuilder<List<PaymentData>>(
        stream: readPayUser(widget.userPhoneNum),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(PaymentData user) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentMoreDetails(
                //userUID: widget.userUID,
                userPhoneNum: user.userNumber,
                userMonth: user.month,
              ),
            ),
          );
        },
        child: ListTile(
          title: Text("PAID"),
          subtitle: Text(user.id),
        ),
      );

  // Future<PaymentData?> readPayUsers(String phoneNum) async {
  //   //get single document by id
  //   final docUser =
  //       FirebaseFirestore.instance.collection("PaymentData").doc(phoneNum);

  //   final snapshot = await docUser.get();
  //   if (snapshot.exists) {
  //     return PaymentData.fromJson(snapshot.data()!);
  //   }
  // }
  Stream<List<PaymentData>> readPayUser(String phoneNum) =>
      FirebaseFirestore.instance
          .collection("PaymentData")
          .doc(phoneNum)
          .collection('Months')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => PaymentData.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
}
