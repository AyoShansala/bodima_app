import 'package:bording_login_ui/screens/auth/login_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Firebase OTP variables and Initializations
  TextEditingController mobileNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdNumber = "";
  User? user;
  //End Firebase OTP

  //user check conditions
  // final CollectionReference _userData =
  //     FirebaseFirestore.instance.collection("UserData");
  // void conditionCheck() async {
  //   var mobilNum = mobileNumberController;

  //   print("##this future method execute");

  //   if (mobilNum == mobilNum) {
  //     print("this Number already used");
  //   } else {
  //     print("OTP method execute");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/landscaping-ideas-hbx060117bartholomew13-1654206150.jpg?crop=0.869xw:1.00xh;0.0969xw,0&resize=980:*'),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: TextField(
                                  controller: mobileNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter your Phone Number',
                                    labelStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: OutlinedButton(
                                    child: Text("Get OTP"),
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.green,
                                      // onSurface: Colors.orangeAccent,

                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width -
                                              60,
                                          40),
                                    ),
                                    onPressed: () {
                                      //conditionCheck();
                                      loginWithPhone();
                                      print("####button clicked*****");
                                      Future.delayed(Duration(seconds: 20), () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VerificationScreen(
                                              verified: verificationIdNumber,
                                              userPhoneNum:
                                                  mobileNumberController.text,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
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

  //OTP Number Verification
  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+94" + mobileNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationIdNumber = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
