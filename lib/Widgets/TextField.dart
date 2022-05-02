import 'package:flutter/material.dart';

Widget buildTextField({required String label, required String prefix, required String hint, required TextEditingController controller, required Function(String) checkChanged}){

  return TextField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      hintText: '$hint',
      label: Text('$label'),
      prefixText: '$prefix',
    ),
    onChanged: checkChanged,
  );
}