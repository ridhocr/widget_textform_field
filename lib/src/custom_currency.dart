import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Menghapus semua karakter non-digit
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    // Mengonversi ke format Rupiah
    String formatted = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(int.parse(digitsOnly));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length), // Menjaga posisi kursor di akhir
    );
  }
}

class ConvertRupiah {
  static convert(String digitsOnly)  {
    String formatted = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(int.parse(digitsOnly));

    return formatted;
  }
}
