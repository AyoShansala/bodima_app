import 'package:bording_login_ui/screens/user_screens/add_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentMoreDetails extends StatefulWidget {
  const PaymentMoreDetails({
    Key? key,
    //required this.userUID,
    required this.userPhoneNum,
    required this.userMonth,
  }) : super(key: key);
  //final String userUID;
  final String userPhoneNum;
  final String userMonth;

  @override
  State<PaymentMoreDetails> createState() => _PaymentMoreDetailsState();
}

class _PaymentMoreDetailsState extends State<PaymentMoreDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.edit),
            ),
          ),
        ],
        leading: const IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        title: const Text("Full Details"), // Title............
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder<PaymentData?>(
            future:
                readSingleUserDetails(widget.userPhoneNum, widget.userMonth),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final singleUser = snapshot.data!;
                return singleUser == null
                    ? Center(
                        child: Text('Something Wrong Single user'),
                      )
                    : Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('PAYMENT STATUS >>'),
                                subtitle: Text(singleUser.paymentStatus),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('MONTH >>'),
                                subtitle: Text(singleUser.month),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('AMOUNT OF PAIED >>'),
                                subtitle: Text(singleUser.amountOfpayment),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('YEAR >>'),
                                subtitle: Text(singleUser.year),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => UserPaymentScreen(
                                    //       userUID: widget.userUID,
                                    //       userPhoneNum: widget.userPhoneNum,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.green,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      'Noted',
                                      style: TextStyle(
                                        fontSize: 22,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<PaymentData?> readSingleUserDetails(
    String phoneNum,
    String monthName,
  ) async {
    //get single document by id
    print(monthName);
    print(phoneNum);
    final docUser = FirebaseFirestore.instance
        .collection("PaymentData")
        .doc(phoneNum)
        .collection('Months')
        .doc(monthName);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return PaymentData.fromJson(snapshot.data()!);
    }
    print(snapshot.data());
  }
}
