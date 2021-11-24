import 'package:intl/intl.dart';

class NumberUtils {
  static String parseCurrencyWithUnit(double? number) {
    if (number != null)
      return '${NumberFormat.currency(locale: 'vi', customPattern: '#,### VNĐ').format(number)}';
    else
      return '';
  }

  static String? parseCurrency(double? number) {
    String numberFormatted = number.toString();
    if (number != null) {
      numberFormatted =
          '${NumberFormat.currency(locale: 'vi', customPattern: '#,###').format(number)}';
      return numberFormatted;
    } else
      return null;
  }
}
