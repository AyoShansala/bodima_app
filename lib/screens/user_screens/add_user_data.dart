import 'package:bording_login_ui/screens/user_screens/view_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    Key? key,
    required this.userUID,
    required this.userPhoneNum,
  }) : super(key: key);
  final String userUID;
  final String userPhoneNum;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameTxtController = TextEditingController();
  final TextEditingController _addressTxtController = TextEditingController();
  final TextEditingController _roomNumTxtController = TextEditingController();
  final TextEditingController _phoneNumTxtController = TextEditingController();
  final TextEditingController _secondPhoneNumTxtController =
      TextEditingController();
  final TextEditingController _idNumTxtController = TextEditingController();

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
        title: const Text("Add User Data"), // Title............
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
                      "Name",
                      TextInputType.name,
                      _nameTxtController,
                    ),
                    const SizedBox(height: 20),
                    inputField(
                      "Address",
                      TextInputType.name,
                      _addressTxtController,
                    ),
                    const SizedBox(height: 20),
                    inputField(
                      "Room Number",
                      TextInputType.number,
                      _roomNumTxtController,
                    ),
                    const SizedBox(height: 20),
                    inputField(
                      "Parent Phone Number",
                      TextInputType.number,
                      _phoneNumTxtController,
                    ),
                    const SizedBox(height: 20),
                    inputField(
                      "Parent Phone Number",
                      TextInputType.number,
                      _secondPhoneNumTxtController,
                    ),
                    const SizedBox(height: 20),
                    inputField(
                      "ID Number",
                      TextInputType.name,
                      _idNumTxtController,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // Database.userPhoneNum = widget.userPhoneNum;
                          // Database.addItem(
                          //   name: _nameTxtController.text,
                          //   address: _addressTxtController.text,
                          //   roomNum: _roomNumTxtController.text,
                          //   parentPhoneNum1: _phoneNumTxtController.text,
                          //   parentPhonenum2: _secondPhoneNumTxtController.text,
                          //   idNum: _idNumTxtController.text,
                          // );

                          final userTest = UsersData(
                            name: _nameTxtController.text,
                            address: _addressTxtController.text,
                            roomNumber: _roomNumTxtController.text,
                            phoneNumber1: _phoneNumTxtController.text,
                            phoneNumber2: _secondPhoneNumTxtController.text,
                            idNumber: _idNumTxtController.text,
                          );
                          createUser(userTest, widget.userPhoneNum);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewUserData(
                                userUID: widget.userUID,
                                userPhoneNum: widget.userPhoneNum,
                              ),
                            ),
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
          ),
        ),
      ),
    );
  }

  Future createUser(UsersData user, String phoneNumber) async {
    //reference to document
    final docUser =
        FirebaseFirestore.instance.collection("UsersData").doc(phoneNumber);
    user.id = docUser.id;
    final json = user.toJson();

    //create document and write data to firebase
    await docUser.set(json);
  }
}

//.......user_data_model.................................
class UsersData {
  String id;
  final String name;
  final String address;
  final String roomNumber;
  final String phoneNumber1;
  final String phoneNumber2;
  final String idNumber;
  UsersData({
    this.id = '',
    required this.name,
    required this.address,
    required this.roomNumber,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.idNumber,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'Name': name,
        'Address': address,
        'Room_Number': roomNumber,
        'Phone_Number1': phoneNumber1,
        'Phone_Number2': phoneNumber2,
        'ID_Number': idNumber,
      };

  static UsersData fromJson(Map<String, dynamic> json) => UsersData(
        id: json['id'].toString(),
        name: json['Name'].toString(),
        address: json['Address'].toString(),
        roomNumber: json['Room_Number'].toString(),
        phoneNumber1: json['Phone_Number1'].toString(),
        phoneNumber2: json['Phone_Nummber2'].toString(),
        idNumber: json['ID_Number'].toString(),
      );
}
