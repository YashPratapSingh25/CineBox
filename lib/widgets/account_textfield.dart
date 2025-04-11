import 'package:flutter/material.dart';

class AccountTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool email;
  final bool phone;

  const AccountTextfield({
    Key? key,
    required this.controller,
    required this.label,
    this.email = false,
    this.phone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: phone
          ? TextInputType.phone
          : email
          ? TextInputType.emailAddress
          : TextInputType.name,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (email && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        if (phone && value.length != 10) {
          return 'Enter a valid 10-digit phone number';
        }
        return null;
      },
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
