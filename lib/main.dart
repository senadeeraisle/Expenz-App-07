import 'package:expenz/services/user_details_service.dart';
import 'package:expenz/widget/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.userNameExists(),

      builder: (context, snapshot) {
        //if the snapshot is still waiting, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          //here the usaerExists will be set to true if the data is there in the snapshot else return false
          bool userExists = snapshot.data ?? false;
          return MaterialApp(
            theme: ThemeData(fontFamily: "Inter"),
            debugShowCheckedModeBanner: false,
            home: Wrapper(showMainScreen: userExists),
          );
        }
      },
    );
  }
}
