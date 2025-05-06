import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  final Color? textColor;

  const PrimaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white30,
        side: const BorderSide(
          width: 1,
          color: Colors.black,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor,
          fontSize: 19.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
