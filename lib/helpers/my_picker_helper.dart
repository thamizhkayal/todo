import 'package:flutter/material.dart';

class MyPickerHelper {
  static Future<DateTime?> datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2));
    return pickedDate;
  }
}
