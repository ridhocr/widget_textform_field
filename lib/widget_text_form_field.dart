library widget_text_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:widget_text_form_field/src/custom_colors.dart';
import 'package:widget_text_form_field/src/custom_currency.dart';

/// A Calculator.

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? validator;
  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final TextInputType? keyboardType;
  final String? type;
  final bool obscureText;
  final int? maxLines;
  final int? maxlenght;
  final bool? readOnly;
  final bool? currency;
  final Function? onChanged;
  final TextStyle? labelStyle;
  final Color? colorDate;
  final Color? colorYear;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.labelText,
      required this.hintText,
      this.prefixIcon,
      this.borderRadius = 10.0,
      this.keyboardType,
      this.type = "",
      this.suffixIcon,
      this.obscureText = false,
      this.maxLines,
      this.maxlenght,
      this.readOnly,
      this.currency,
      this.onChanged,
      this.labelStyle,
      this.colorDate,
      this.colorYear});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 14),
      decoration: BoxDecoration(
        color: readOnly ?? false ? black10 : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: black40, width: 2),
      ),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          if (type == "email") {
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return "Enter a valid email";
            }
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        keyboardType: type == "email"
            ? TextInputType.emailAddress
            : type == "password"
                ? TextInputType.visiblePassword
                : type == "number"
                    ? TextInputType.number
                    : type == "date"
                        ? TextInputType.none
                        : type == "year"
                            ? TextInputType.none
                            : keyboardType,
        readOnly: type == "date" || type == "year" ? true : readOnly ?? false,
        onTap: type == "date"
            ? () => _selectDate(context, colorDate ?? Colors.white)
            : type == "year"
                ? () => _showYearPicker(context, colorYear ?? Colors.white)
                : null,
        onChanged: (value) => onChanged != null ? onChanged!(value) : null,
        enableSuggestions: type == "password" ? false : true,
        autocorrect: type == "password" ? false : true,
        inputFormatters: currency == true ? [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyTextInputFormatter(), 
        ] : [],
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: readOnly ?? false,
          fillColor: black10,
          contentPadding:
              maxLines != 1 ? const EdgeInsets.only(top: 30) : EdgeInsets.zero,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusColor: black100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          labelText: labelText,
          labelStyle: labelStyle ?? TextStyle(
              color: black80, fontSize: 14, fontWeight: FontWeight.w400),
          hintText: hintText,
          hintStyle: TextStyle(
              color: readOnly == true ? black80 : black20,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis),
          prefixIcon: prefixIcon,
          suffixIcon: type == "date" || type == "year"
              ? const Icon(Icons.calendar_month_outlined)
              : suffixIcon,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(borderRadius),
          //   borderSide: BorderSide.none,
          // ),
        ),
        maxLines: maxLines,
        maxLength: maxlenght,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, Color color) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: color,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _showYearPicker(BuildContext context, Color color) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: const Text('Select Year'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            child: YearPicker(
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                Navigator.of(context).pop(dateTime);
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      controller.text = picked.year.toString();
    }
  }
}

