import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

List<String> _list = [];

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown<String>(
          hintText: 'Select job role',
          items: _list,
          decoration: CustomDropdownDecoration(),
          noResultFoundBuilder: (context, text) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          excludeSelected: false,
          onChanged: (value) {
            log('SimpleDropdown onChanged value: $value');
          },
        ),
        const SizedBox(height: 50),
        TextButton(
            onPressed: () {
              _list = [
                'Developer',
                'Designer',
                'Consultant',
                'Student',
              ];
            },
            child: Text("Submit"))
      ],
    );
  }
}
