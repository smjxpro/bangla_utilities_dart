import 'package:bangla_utilities/bangla_number.dart';

// ---------------------------------------------------------------------------
// Module-private constants
// ---------------------------------------------------------------------------

/// Bangla month names ordered to align with the Gregorian month index
/// (January == index 0, which falls in পৌষ).
const List<String> _gregEquivalentBanglaMonths = [
  'পৌষ',
  'মাঘ',
  'ফাল্গুন',
  'চৈত্র',
  'বৈশাখ',
  'জ্যৈষ্ঠ',
  'আষাঢ়',
  'শ্রাবণ',
  'ভাদ্র',
  'আশ্বিন',
  'কার্তিক',
  'অগ্রহায়ণ',
];

const List<String> _banglaWeekdays = [
  'সোমবার',
  'মঙ্গলবার',
  'বুধবার',
  'বৃহস্পতিবার',
  'শুক্রবার',
  'শনিবার',
  'রবিবার',
];

const List<String> _gregEquivalentBanglaSeasons = [
  'শীত',
  'বসন্ত',
  'গ্রীষ্ম',
  'বর্ষা',
  'শরৎ',
  'হেমন্ত',
];

/// Last Gregorian day of each Gregorian month that still belongs to the
/// *previous* Bangla month (i.e., the day before the Bangla month starts).
const List<int> _gregEquivalentLastDayOfBanglaMonths = [
  13,
  12,
  14,
  13,
  14,
  14,
  15,
  15,
  15,
  15,
  14,
  14,
];

/// Days in each Bangla month (index 0 == পৌষ).
const List<int> _totalDaysInBanglaMonths = [
  30,
  30,
  30,
  30,
  31,
  31,
  31,
  31,
  31,
  30,
  30,
  30,
];

/// Index of ফাল্গুন (the month that gains a day in a Gregorian leap year).
const int _leapYearBanglaMonthIndex = 2;

// ---------------------------------------------------------------------------
// BanglaDate
// ---------------------------------------------------------------------------

/// Represents a date in the Bangla (Bengali/Bangla Calendar / বাংলা পঞ্জিকা)
/// system, derived from a Gregorian input.
///
/// ```dart
/// final today = BanglaDate.today();
/// print('${today.dayInt} ${today.monthName} ${today.yearInt}');
///
/// final historical = BanglaDate.fromDateTime(DateTime(2020, 5, 31));
/// print(historical.date); // ১৭-৫-১৪২৭
/// ```
class BanglaDate {
  /// Bangla day numeral string (e.g. `'১৭'`).
  final String day;

  /// Bangla month numeral string (e.g. `'৫'`).
  final String month;

  /// Bangla year numeral string (e.g. `'১৪২৭'`).
  final String year;

  /// Bangla month name (e.g. `'জ্যৈষ্ঠ'`).
  final String monthName;

  /// Bangla weekday name (e.g. `'রবিবার'`).
  final String weekday;

  /// Bangla season name (e.g. `'গ্রীষ্ম'`).
  final String season;

  /// Whether the source Gregorian year is a leap year.
  final bool isLeapYear;

  /// Raw Bangla day as an integer.
  final int dayInt;

  /// Raw Bangla month as an integer (1-based).
  final int monthInt;

  /// Raw Bangla year as an integer.
  final int yearInt;

  /// Formatted date string: `'day-month-year'` in Bangla numerals.
  String get date => '$day-$month-$year';

  const BanglaDate._({
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.weekday,
    required this.season,
    required this.isLeapYear,
    required this.dayInt,
    required this.monthInt,
    required this.yearInt,
  });

  // ── Factories ─────────────────────────────────────────────────────────────

  /// Creates a [BanglaDate] for today's date.
  factory BanglaDate.today() => BanglaDate.fromDateTime(DateTime.now());

  /// Creates a [BanglaDate] from a [DateTime] object.
  factory BanglaDate.fromDateTime(DateTime dateTime) =>
      BanglaDate.fromEnglishYearMonthDay(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
      );

  /// Creates a [BanglaDate] from an ISO 8601 date [String] (e.g.
  /// `'2020-05-31'`). Uses today's date if [dateString] is `null`.
  factory BanglaDate.fromEnglishDate([String? dateString]) {
    final DateTime dt =
        dateString == null ? DateTime.now() : DateTime.parse(dateString);
    return BanglaDate.fromDateTime(dt);
  }

  /// Creates a [BanglaDate] from individual Gregorian year, month, and day
  /// components. Each parameter defaults to the corresponding component of
  /// today's date when omitted.
  factory BanglaDate.fromEnglishYearMonthDay({
    int? year,
    int? month,
    int? day,
  }) {
    // Resolve defaults once so helpers never call DateTime.now() independently.
    final DateTime now = DateTime.now();
    final int resolvedYear = year ?? now.year;
    final int resolvedMonth = month ?? now.month;
    final int resolvedDay = day ?? now.day;

    final bool leap = _computeIsLeapYear(resolvedYear);

    // Weekday — DateTime weekday: 1=Mon … 7=Sun
    final String banglaWeekday = _banglaWeekdays[
        DateTime(resolvedYear, resolvedMonth, resolvedDay).weekday - 1];

    // Bangla year
    final int banglaYearInt = _computeBanglaYear(
      year: resolvedYear,
      month: resolvedMonth,
      day: resolvedDay,
    );

    // Bangla month & day (use 0-based month index into the lookup tables)
    final int monthIndex = resolvedMonth - 1; // 0-based
    final int banglaMonthArrayIndex;
    final int banglaDayInt;

    if (resolvedDay <= _gregEquivalentLastDayOfBanglaMonths[monthIndex]) {
      // Still in the previous Bangla month.
      int daysInBanglaMonth = _totalDaysInBanglaMonths[monthIndex];
      if (monthIndex == _leapYearBanglaMonthIndex && leap) {
        daysInBanglaMonth += 1;
      }
      banglaDayInt = daysInBanglaMonth +
          resolvedDay -
          _gregEquivalentLastDayOfBanglaMonths[monthIndex];
      banglaMonthArrayIndex = monthIndex;
    } else {
      // Already into the next Bangla month.
      banglaDayInt =
          resolvedDay - _gregEquivalentLastDayOfBanglaMonths[monthIndex];
      banglaMonthArrayIndex = (monthIndex + 1) % 12;
    }

    // Convert 0-based array index to the true 1-based Bangla month number:
    // পৌষ(0)→9, মাঘ(1)→10, ফাল্গুন(2)→11, চৈত্র(3)→12, বৈশাখ(4)→1, …
    final int banglaMonthInt = (banglaMonthArrayIndex + 8) % 12 + 1;

    final String season =
        _gregEquivalentBanglaSeasons[banglaMonthArrayIndex ~/ 2];
    final String monthName = _gregEquivalentBanglaMonths[banglaMonthArrayIndex];

    return BanglaDate._(
      day: BanglaNumber.fromEnglish(banglaDayInt).value,
      month: BanglaNumber.fromEnglish(banglaMonthInt).value,
      year: BanglaNumber.fromEnglish(banglaYearInt).value,
      monthName: monthName,
      weekday: banglaWeekday,
      season: season,
      isLeapYear: leap,
      dayInt: banglaDayInt,
      monthInt: banglaMonthInt,
      yearInt: banglaYearInt,
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  /// Returns `true` if [year] is a Gregorian leap year.
  static bool _computeIsLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 4 == 0 && year % 100 != 0) return true;
    return false;
  }

  /// Computes the Bangla year for the given Gregorian date components.
  static int _computeBanglaYear({
    required int year,
    required int month,
    required int day,
  }) {
    if (month > 3) return year - 593;
    if (month == 3 && day > 13) return year - 593;
    return year - 594;
  }
}
