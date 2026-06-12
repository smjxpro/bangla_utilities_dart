import 'package:bangla_utilities/bangla_date.dart';
import 'package:bangla_utilities/bangla_number.dart';

/// Formats a [BanglaDate] using a pattern string.
///
/// Supported tokens (longer tokens take precedence over shorter ones):
///
/// | Token  | Description                         | Example     |
/// |--------|-------------------------------------|-------------|
/// | `YYYY` | Full Bangla year (4 digits)         | `১৪৩০`      |
/// | `YY`   | Last 2 Bangla digits of year        | `৩০`        |
/// | `MM`   | Zero-padded 2-digit Bangla month    | `০৯`        |
/// | `M`    | Bangla month without leading zero   | `৯`         |
/// | `DD`   | Zero-padded 2-digit Bangla day      | `০২`        |
/// | `D`    | Bangla day without leading zero     | `২`         |
/// | `d`    | Bangla weekday name                 | `সোমবার`    |
/// | `S`    | Bangla season name                  | `শীত`       |
///
/// ```dart
/// final date = BanglaDate.fromEnglishDate('2024-01-01');
/// print(BanglaDateFormatter('DD/MM/YYYY').format(date)); // ১৮/০৯/১৪৩০
/// print(BanglaDateFormatter('d, S').format(date));       // সোমবার, শীত
/// ```
class BanglaDateFormatter {
  /// The format pattern string.
  final String pattern;

  const BanglaDateFormatter(this.pattern);

  /// Formats [date] according to [pattern].
  ///
  /// Tokens are replaced longest-first to avoid partial collisions
  /// (e.g. `YYYY` before `YY`, `MM` before `M`, `DD` before `D`).
  String format(BanglaDate date) {
    final String fullYear = date.year;
    final String shortYear = _lastTwoRunes(fullYear);
    final String paddedMonth = _padTwo(date.monthInt);
    final String paddedDay = _padTwo(date.dayInt);

    return pattern
        .replaceAll('YYYY', fullYear)
        .replaceAll('YY', shortYear)
        .replaceAll('MM', paddedMonth)
        .replaceAll('M', date.month)
        .replaceAll('DD', paddedDay)
        .replaceAll('D', date.day)
        .replaceAll('d', date.weekday)
        .replaceAll('S', date.season);
  }

  /// Returns the last 2 Unicode characters of [s] using rune-safe slicing.
  static String _lastTwoRunes(String s) {
    final List<int> runes = s.runes.toList();
    if (runes.length < 2) return s;
    return String.fromCharCodes(runes.sublist(runes.length - 2));
  }

  /// Returns a zero-padded 2-rune Bangla numeral string for [n].
  static String _padTwo(int n) {
    final String s = BanglaNumber.fromEnglish(n).value;
    return s.runes.length < 2 ? '০$s' : s;
  }
}
