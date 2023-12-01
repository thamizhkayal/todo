import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.controller,
      this.isError = false,
      this.hintText = 'Enter text',
      this.onChange});

  final TextEditingController? controller;
  final bool isError;
  final String hintText;
  final ValueChanged? onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.grey[300],
          border: Border.all(
              width: 2, color: isError ? Colors.red : Colors.transparent)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(16.0),
          border: InputBorder.none,
        ),
        onChanged: onChange,
      ),
    );
  }
}
