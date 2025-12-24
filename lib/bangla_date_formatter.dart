import 'package:bangla_utilities/bangla_date.dart';
import 'package:bangla_utilities/bangla_number.dart';

class BanglaDateFormatter {
  final String _format;

  BanglaDateFormatter(this._format);

  String format(BanglaDate date) {
    String formattedDate = _format;
    formattedDate = formattedDate.replaceAll('DD', date.day.padLeft(2, '০'));
    formattedDate = formattedDate.replaceAll('D', date.day.startsWith('০') ? date.day.substring(1) : date.day);
    formattedDate = formattedDate.replaceAll('MM', date.month.padLeft(2, '০'));
    formattedDate = formattedDate.replaceAll('M', date.month);
    formattedDate = formattedDate.replaceAll('YYYY', date.year);
    formattedDate = formattedDate.replaceAll('YY', date.year.substring(2));
    formattedDate = formattedDate.replaceAll('d', date.weekday);
    formattedDate = formattedDate.replaceAll('S', date.season);
    return formattedDate;
  }
}
