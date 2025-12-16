import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //Store user details in shared preferences
  static Future<void> storeUserDetails({
    required String name,
    required String email,
    required String password,
    required String repassword,
    required BuildContext context,
  }) async {
    try {
      if (password != repassword) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Password do not match")));
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User details saved successfully")),
        );
      }
    } catch (error) {
      error.toString();
    }
  }

  //check if user details exist
  static Future<bool> userNameExists() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName = pref.getString("user_name");
    return userName != null;
  }
}
