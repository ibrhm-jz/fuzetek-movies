import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formattDate(date) {
  initializeDateFormatting();
  String dateString;
  dateString = DateFormat('d/MMMM/y', 'es').format(date);
  return dateString;
}
