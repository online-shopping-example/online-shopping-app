import 'package:flutter/material.dart';

class PrimaryTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? labelText;
  final int? maxLength;
  final Color? textColor;
  final void Function()? onChange;

  const PrimaryTextFormFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.readOnly,
    this.labelText,
    this.maxLength,
    this.textColor,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      onTap: onChange,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: readOnly == true ? Colors.grey : textColor,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
