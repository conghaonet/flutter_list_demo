import 'package:flutter/material.dart';

class ProvinceNotifier extends ChangeNotifier {
  void refreshProvince() {
    notifyListeners();
  }
}