import 'package:bangla_utilities/bangla_number.dart';

const _gregEquivalentBanglaMonths = [
  "পৌষ",
  "মাঘ",
  "ফাল্গুন",
  "চৈত্র",
  "বৈশাখ",
  "জ্যৈষ্ঠ",
  "আষাঢ়",
  "শ্রাবণ",
  "ভাদ্র",
  "আশ্বিন",
  "কার্তিক",
  "অগ্রহায়ণ",
];

const banglaWeekdays = [
  "সোমবার",
  "মঙ্গলবার",
  "বুধবার",
  "বৃহস্পতিবার",
  "শুক্রবার",
  "শনিবার",
  "রবিবার",
];
const _gregEquivalentBanglaSeasons = [
  "শীত",
  "বসন্ত",
  "গ্রীষ্ম",
  "বর্ষা",
  "শরৎ",
  "হেমন্ত",
];

const _gregEquivalentLastDayOfBanglaMonths = [
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

const totalDaysInBanglaMonths = [
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

const gregEquivalentLeapYearIndexInBanglaMonths = 2;

class BanglaDate {
  final String day;
  final String month;
  final String year;
  final String monthName;
  final String weekday;
  final String season;
  final bool isLeapYear;

  final String date;

  BanglaDate._({
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.weekday,
    required this.season,
    required this.isLeapYear,
    required this.date,
  });

  factory BanglaDate.fromEnglishYearMonthDay({
    int? year,
    int? month,
    int? day,
  }) {
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;
    day ??= DateTime.now().day;

    var bangla = _getBanglaDateMonthYearSeason(
      year: year,
      month: month,
      day: day,
    );
    return BanglaDate._(
      day: bangla['day']!,
      month: bangla['month']!,
      year: bangla['year']!,
      monthName: bangla['monthName']!,
      weekday: bangla['weekday']!,
      season: bangla['season']!,
      isLeapYear: _isLeapYear(year: year),
      date: '${bangla['day']}-${bangla['month']}-${bangla['year']}',
    );
  }

  factory BanglaDate.fromEnglishDate([String? dateString]) {
    DateTime dateTime;
    if (dateString == null) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.parse(dateString);
    }

    return BanglaDate.fromEnglishYearMonthDay(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  /// Checks if given English year is a leap  year
  /// ```dart
  /// BanglaUtility.isLeapYear(2020) == true
  /// ```
  static bool _isLeapYear({int? year}) {
    year ??= DateTime.now().year;
    if (year % 400 == 0) {
      return true;
    } else if (year % 4 == 0 && year % 100 != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Returns Bangla year for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaYear(day:31, month:05, year: 2020) == '১৪২৭'
  /// ```
  static String _getBanglaYear({int? day, int? month, int? year}) {
    DateTime now = DateTime.now();

    year ??= now.year;
    month ??= now.month;

    day ??= now.day;

    int banglaYear;
    if (month > 3) {
      banglaYear = year - 593;
    } else if (month == 3 && day > 13) {
      banglaYear = year - 593;
    } else {
      banglaYear = year - 594;
    }
    return BanglaNumber.fromEnglish(banglaYear).toString();
  }

  /// Returns Bangla weekday for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaWeekday(day:31, month:05, year: 2020) == 'রবিবার'
  /// ```
  static String _getBanglaWeekday({int? day, int? month, int? year}) {
    DateTime now = DateTime.now();

    year ??= now.year;
    month ??= now.month;

    day ??= now.day;

    DateTime date = DateTime(year, month, day);
    String banglaWeekday = banglaWeekdays[date.weekday - 1];
    return banglaWeekday;
  }

  /// Returns map of Bangla weekday, day, month, month name, year, season for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaDateMonthYearSeason(day:31, month:05, year: 2020) == {
  ///       "weekday": 'রবিবার',
  ///       "day": '১৭',
  ///       "month": '৫',
  ///       "monthName": 'জ্যৈষ্ঠ',
  ///       "year": '১৪২৭',
  ///       "season": 'গ্রীষ্ম'
  ///     }
  /// ```
  static Map<String, String> _getBanglaDateMonthYearSeason({
    int? day,
    int? month,
    int? year,
  }) {
    int banglaDay;
    int banglaMonth;
    String banglaMonthName;
    String banglaYear;

    DateTime now = DateTime.now();

    year ??= now.year;

    month ??= now.month;

    day ??= now.day;

    String banglaWeekday = _getBanglaWeekday(
      day: day,
      month: month,
      year: year,
    );
    month = month - 1;
    banglaYear = _getBanglaYear(day: day, month: month, year: year);

    if (day <= _gregEquivalentLastDayOfBanglaMonths[month]) {
      int totalDaysInCurrentBanglaMonth = totalDaysInBanglaMonths[month];
      if (month == gregEquivalentLeapYearIndexInBanglaMonths &&
          _isLeapYear(year: year)) {
        totalDaysInCurrentBanglaMonth += 1;
      }
      banglaDay =
          totalDaysInCurrentBanglaMonth +
          day -
          _gregEquivalentLastDayOfBanglaMonths[month];
      banglaMonth = month;
      banglaMonthName = _gregEquivalentBanglaMonths[banglaMonth];
    } else {
      banglaDay = day - _gregEquivalentLastDayOfBanglaMonths[month];
      banglaMonth = (month + 1) % 12;
      banglaMonthName = _gregEquivalentBanglaMonths[banglaMonth];
    }

    String banglaSeason = _gregEquivalentBanglaSeasons[banglaMonth ~/ 2];

    return {
      "weekday": banglaWeekday,
      "day": BanglaNumber.fromEnglish(banglaDay).value,
      "month": BanglaNumber.fromEnglish(banglaMonth).value,
      "monthName": banglaMonthName,
      "year": banglaYear,
      "season": banglaSeason,
    };
  }
}
