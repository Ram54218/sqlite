import 'package:flutter/material.dart';

class CommonWidget {
  static showSnackBar(String message) {
    return SnackBar(content: Text(message));
  }

  static const detailScreenTextStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal);
}
