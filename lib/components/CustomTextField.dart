import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  TextEditingController? controller;
  CustomTextField({required this.hintText, required this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller,
                  decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
              )),
            ),
          )
        ],
      ),
    );
  }
}