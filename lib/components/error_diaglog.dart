import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String firstEventTerm;
  final void Function() firstEventFunction;
  final Color? firstEventColor;
  final String? secondEventTerm;
  final void Function()? secondEventFunction;
  final Color? secondEventColor;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.firstEventTerm,
    required this.firstEventFunction,
    this.secondEventTerm,
    this.secondEventFunction,
    this.firstEventColor,
    this.secondEventColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error,
        size: 40.0,
      ),
      iconColor: Colors.red,
      title: Text(
        title,
        textAlign: TextAlign.start,
      ),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: firstEventFunction,
          child: Text(
            firstEventTerm,
            style: TextStyle(color: firstEventColor),
          ),
        ),
        secondEventTerm != null
            ? TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(
                  secondEventTerm!,
                  style: TextStyle(color: secondEventColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ],
    );
  }
}
