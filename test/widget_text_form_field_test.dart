import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_text_form_field/widget_text_form_field.dart';

void main() {
  test('adds one to input values', () {
    final textEditingController = TextEditingController(text: '1000');
    final customTextFormField = CustomTextFormField(
      controller: textEditingController,
      labelText: 'Label',
      hintText: 'Hint',
      prefixIcon: const Icon(Icons.add),
      suffixIcon: const Icon(Icons.remove),
      borderRadius: 10.0,
      keyboardType: TextInputType.number,
      type: 'number',
      obscureText: false,
      maxLines: 1,
      maxlenght: 10,
      readOnly: false,
      currency: true,
      onChanged: (value) {},
    );

    expect(customTextFormField.controller.text, '1000');
  });
}
