import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed; // Nuevo parámetro para la función onPressed

  const CustomButton({
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.onPressed, // Asegúrate de agregarlo aquí
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(bgColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
