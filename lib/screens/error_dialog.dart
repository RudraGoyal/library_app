import 'package:flutter/material.dart';

void errorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.cyan[100],
          title: const Text(
            'INVALID Credentials',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
        );
      });
}
