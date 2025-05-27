import 'package:flutter/material.dart';

class PrimarySwitcherWidget extends StatelessWidget {
  final String onText;
  final String offText;
  final bool onOffStatus;
  final void Function(bool) onSwitch;
  const PrimarySwitcherWidget({
    super.key,
    required this.onText,
    required this.offText,
    required this.onOffStatus,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            offText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: !onOffStatus ? Colors.red : null,
            ),
          ),
          Switch(
            value: onOffStatus,
            onChanged: onSwitch,
            activeColor: Colors.green, // When the switch is true
            inactiveThumbColor: Colors.red, // When the switch is false
          ),
          Text(
            onText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: onOffStatus ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}
