import 'package:evently/model/model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  Users? currentUser;
  void updateUser(Users newUser){
    currentUser = newUser;
    notifyListeners();
  }
}