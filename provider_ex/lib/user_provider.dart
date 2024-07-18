import 'package:flutter/material.dart';
import 'user.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;

  void updateUser(String name, int age) {
    _user = User(name, age);
    notifyListeners();
  }
}
