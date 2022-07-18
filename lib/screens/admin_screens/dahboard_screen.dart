import 'dart:developer';
import 'package:bording_login_ui/screens/admin_screens/paid_months.dart';
import 'package:bording_login_ui/screens/user_screens/add_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
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
        title: const Text("Dashboard"), // Title............
        centerTitle: true,
      ),
      body: StreamBuilder<List<UsersData>>(
        stream: readDashboardUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allUsers = snapshot.data!;
            return ListView(
              children: allUsers.map(buildUser).toList(),
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

  //......................Methods.........................................................
  Widget buildUser(UsersData user) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaidMonths(
                userUID: "Not_Need",
                userPhoneNum: user.id,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${user.roomNumber}'),
          ),
          title: Text(user.name),
          subtitle: Text(user.idNumber),
        ),
      );
  //......................................................................................
  Stream<List<UsersData>> readDashboardUser() =>
      FirebaseFirestore.instance.collection("UsersData").snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => UsersData.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
}
