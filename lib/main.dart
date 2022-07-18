import 'package:bording_login_ui/screens/admin_screens/dahboard_screen.dart';
import 'package:bording_login_ui/screens/admin_screens/paid_months.dart';
import 'package:bording_login_ui/screens/admin_screens/payment_more_details.dart';
import 'package:bording_login_ui/screens/user_screens/view_user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth/sing_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashBoardScreen(),
    );
  }
}
