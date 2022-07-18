import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPaymentScreen extends StatefulWidget {
  const UserPaymentScreen({
    Key? key,
    required this.userUID,
    required this.userPhoneNum,
  }) : super(key: key);
  final String userUID;
  final String userPhoneNum;

  @override
  State<UserPaymentScreen> createState() => _UserPaymentScreenState();
}

class _UserPaymentScreenState extends State<UserPaymentScreen> {
  final TextEditingController _yearTxtController = TextEditingController();
  final TextEditingController _monthTxtController = TextEditingController();
  final TextEditingController _statusTxtController = TextEditingController();
  final TextEditingController _feeTextController = TextEditingController();

  // InputField.......................
  Widget inputField(String label, TextInputType inputType,
      TextEditingController allController) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(25)),
      child: TextField(
        controller: allController,
        keyboardType: inputType,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            labelText: label),
      ),
    );
  }

  //......................................
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
        title: const Text("Add User Payment"), // Title............
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: const Color(0xffeeeeee),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      inputField(
                        "Year",
                        TextInputType.name,
                        _yearTxtController,
                      ),
                      const SizedBox(height: 20),
                      inputField(
                        "Month",
                        TextInputType.name,
                        _monthTxtController,
                      ),
                      const SizedBox(height: 20),
                      inputField(
                        "Status(True/false)",
                        TextInputType.number,
                        _statusTxtController,
                      ),
                      const SizedBox(height: 20),
                      inputField(
                        "Monthly Payment",
                        TextInputType.number,
                        _feeTextController,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.green,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            // Database.userPhoneNum = widget.userPhoneNum;
                            // Database.addPayment(
                            //   year: _yearTxtController.text,
                            //   month: _monthTxtController.text,
                            //   payStatus: _statusTxtController.text,
                            //   payFee: _feeTextController.text,
                            // );
                            final payMonth = _monthTxtController.text;
                            final payData = PaymentData(
                              userNumber: widget.userPhoneNum,
                              year: _yearTxtController.text,
                              month: _monthTxtController.text,
                              paymentStatus: _statusTxtController.text,
                              amountOfpayment: _feeTextController.text,
                            );
                            createUserPayment(
                              payData,
                              widget.userPhoneNum,
                              payMonth,
                            );
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future createUserPayment(
      PaymentData user, String phoneNumber, String month) async {
    //reference to payment document
    final docUser = FirebaseFirestore.instance
        .collection("PaymentData")
        .doc(phoneNumber)
        .collection("Months")
        .doc(month);
    user.id = docUser.id;
    final json = user.toJson();

    //create document and write data to firebase
    await docUser.set(json);
  }
}

//.......payment_data_model.................................
class PaymentData {
  String id;
  final String userNumber;
  final String year;
  final String month;
  final String paymentStatus;
  final String amountOfpayment;
  PaymentData({
    this.id = '',
    required this.userNumber,
    required this.year,
    required this.month,
    required this.paymentStatus,
    required this.amountOfpayment,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'User_Phone_Number': userNumber,
        'Year': year,
        'Month': month,
        'Payment_Status': paymentStatus,
        'Amount_Of_Payment': amountOfpayment,
      };

  static PaymentData fromJson(Map<String, dynamic> json) => PaymentData(
        id: json['id'].toString(),
        userNumber: json['User_Phone_Number'].toString(),
        year: json['Year'].toString(),
        month: json['Month'].toString(),
        paymentStatus: json['Payment_Status'].toString(),
        amountOfpayment: json['Amount_Of_Payment'].toString(),
      );
}
