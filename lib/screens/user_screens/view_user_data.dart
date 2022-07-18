import 'package:bording_login_ui/screens/user_screens/add_payment.dart';
import 'package:bording_login_ui/screens/user_screens/add_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUserData extends StatefulWidget {
  const ViewUserData({
    Key? key,
    required this.userUID,
    required this.userPhoneNum,
  }) : super(key: key);
  final String userUID;
  final String userPhoneNum;

  @override
  State<ViewUserData> createState() => _ViewUserDataState();
}

class _ViewUserDataState extends State<ViewUserData> {
  //input Field
  // Widget inputField(
  //   String label,
  //   TextInputType inputType,
  // ) {
  //   return Container(
  //     height: 55,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //         color: const Color(0xffeeeeee),
  //         borderRadius: BorderRadius.circular(25)),
  //     child: TextField(
  //       keyboardType: inputType,
  //       decoration: InputDecoration(
  //         border: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(25),
  //           ),
  //         ),
  //         labelText: label,
  //       ),
  //     ),
  //   );
  // }

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
        title: const Text("User Profile"), // Title............
        centerTitle: true,
      ),
      // body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   child: SingleChildScrollView(
      //     physics: ScrollPhysics(),
      //     child: StreamBuilder<QuerySnapshot>(
      //       stream: Database.readItems(widget.userPhoneNum),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return ListView.builder(
      //             itemCount: snapshot.data!.docs.length,
      //             shrinkWrap: true,
      //             physics: const ScrollPhysics(),
      //             itemBuilder: (context, i) {
      //               QueryDocumentSnapshot x = snapshot.data!.docs[i];
      //               String docId = x.id;
      //               String name = x["Name"];
      //               String address = x["Address"];
      //               String roomNumber = x["Room_Number"];
      //               String mobileNumberOne = x["Parent_Number_1"];
      //               String mobileNumbertwo = x["Parent_Number_2"];
      //               String idNumber = x["ID_Number"];
      //               print("####### This Is Document Id  " + docId);
      //               return Container(
      //                 padding: const EdgeInsets.all(20.0),
      //                 child: Column(
      //                   children: [
      //                     SizedBox(
      //                       height: 10.0,
      //                     ),
      //                     //name

      //                     ListTile(
      //                       title: Text("Name"),
      //                       subtitle: Text(name),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     //address

      //                     ListTile(
      //                       title: Text("Address"),
      //                       subtitle: Text(address),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     //Room Number

      //                     ListTile(
      //                       title: Text("RoomNumber"),
      //                       subtitle: Text(roomNumber),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     //Mobile Number 1

      //                     ListTile(
      //                       title: Text("Mobile Number 1"),
      //                       subtitle: Text(mobileNumberOne),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     //Mobile Number 2

      //                     ListTile(
      //                       title: Text("Mobile Number 2"),
      //                       subtitle: Text(mobileNumbertwo),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     //Identy card Number
      //                     ListTile(
      //                       title: Text("ID Number"),
      //                       subtitle: Text(idNumber),
      //                     ),
      //                     const Divider(
      //                       thickness: 1.5,
      //                       color: Colors.green,
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     //Payment Buttons

      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     SizedBox(
      //                       width: double.infinity,
      //                       child: ElevatedButton(
      //                         onPressed: () async {
      //                           Navigator.of(context).push(
      //                             MaterialPageRoute(
      //                                 builder: (context) => UserPaymentScreen(
      //                                       userUID: widget.userUID,
      //                                       userPhoneNum: widget.userPhoneNum,
      //                                     )),
      //                           );
      //                         },
      //                         style: ButtonStyle(
      //                           foregroundColor:
      //                               MaterialStateProperty.all<Color>(
      //                             Colors.white,
      //                           ),
      //                           backgroundColor:
      //                               MaterialStateProperty.all<Color>(
      //                             Colors.green,
      //                           ),
      //                           shape: MaterialStateProperty.all<
      //                               RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(24.0),
      //                             ),
      //                           ),
      //                         ),
      //                         child: Padding(
      //                           padding: EdgeInsets.all(14.0),
      //                           child: Text(
      //                             'Payments',
      //                             style: TextStyle(
      //                               fontSize: 22,
      //                               letterSpacing: 2,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             },
      //           );
      //         } else {
      //           return const Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder<UsersData?>(
            future: readUsers(widget.userPhoneNum),
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
                                title: Text('NAME >>'),
                                subtitle: Text(singleUser.name),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('ADDRESS >>'),
                                subtitle: Text(singleUser.address),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('PHONE NUMBER 1 >>'),
                                subtitle: Text(singleUser.phoneNumber1),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('PHONE NUMBER 2 >>'),
                                subtitle: Text(singleUser.phoneNumber2),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text("ROOM NUMBER >>"),
                                subtitle: Text(singleUser.name),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                title: Text('ID NUMBER'),
                                subtitle: Text(singleUser.idNumber),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UserPaymentScreen(
                                          userUID: widget.userUID,
                                          userPhoneNum: widget.userPhoneNum,
                                        ),
                                      ),
                                    );
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
                                      'Payments',
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

  Future<UsersData?> readUsers(String phoneNumber) async {
    //get single document by id
    final docUser =
        FirebaseFirestore.instance.collection("UsersData").doc(phoneNumber);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return UsersData.fromJson(snapshot.data()!);
    }
  }
}
