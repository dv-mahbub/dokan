import 'package:dokan/models/user_info_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserInfoModel? _userData;

  UserInfoModel? get userData => _userData;

  void updateUserData(UserInfoModel newUserInfo) {
    _userData = newUserInfo;
    notifyListeners();
  }

  void deleteUserData() {
    _userData = null; // Reset user data to null
    notifyListeners(); // Notify listeners after data reset
  }
}
