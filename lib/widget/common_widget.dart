import 'package:flutter/material.dart';

class CommonWidget {
  static showSnackBar(String message) {
    return SnackBar(content: Text(message));
  }
}
