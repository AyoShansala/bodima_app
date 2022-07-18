import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../user_screens/add_user_data.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({
    Key? key,
    required this.verified,
    required this.userPhoneNum,
  }) : super(key: key);
  final String verified;
  final String userPhoneNum;

  @override
  State<VerificationScreen> createState() => _VerificationScreen();
}

class _VerificationScreen extends State<VerificationScreen> {
  //Firebase OTP variables and Initializations
  TextEditingController otpCodeController = TextEditingController();
  var otpNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Image.network(
                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/landscaping-ideas-hbx060117bartholomew13-1654206150.jpg?crop=0.869xw:1.00xh;0.0969xw,0&resize=980:*'),
                  Container(
                    color: Colors.green.withOpacity(0.6),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height / 25,
                      left: MediaQuery.of(context).size.width / 3,
                      right: MediaQuery.of(context).size.width / 3,
                      child: Image.asset(
                        'assets/Vector.png',
                        width: MediaQuery.of(context).size.width / 2,
                      )),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    bottom: MediaQuery.of(context).size.height / 2.5,
                    left: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width / 6,
                    child: Text("please enter your OTP sent ",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.2,
                    bottom: MediaQuery.of(context).size.height / 2.2,
                    left: MediaQuery.of(context).size.width / 4.5,
                    right: MediaQuery.of(context).size.width / 4.5,
                    child: Text("to your phone number",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white.withOpacity(1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: const Color(0xFF000000),

                                    showFieldAsBox: true,

                                    onSubmit: (String verificationCode) {
                                      otpNumber = verificationCode;
                                    },

                                    // end onSubmit
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('did not receive the code?',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  )),
                              TextButton(
                                  onPressed: () {}, child: Text('Resend Code'))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                child: OutlinedButton(
                                  child: Text("Verify",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      )),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.green,
                                    // onSurface: Colors.orangeAccent,
                                    // side:
                                    // BorderSide(color: Colors.deepOrange, width: 1),

                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width - 60,
                                        40),
                                  ),
                                  onPressed: () {
                                    verifyOTP(
                                      widget.verified,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              top: MediaQuery.of(context).size.width,
              left: 0,
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP(String verificationID) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: otpNumber,
    );

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
        print("You are logged in successfully");
      },
    ).whenComplete(
      () {
        if (user != null) {
          print("This Is ########## $verificationID");
          print(user!.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(
                userUID: user!.uid,
                userPhoneNum: widget.userPhoneNum,
              ),
            ),
          );
        } else {
          print("****loging Problem****");
        }
      },
    );
  }
}
