import 'package:bangla_utilities/bangla_number.dart';

/// English month to Bangla month conversion constants
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

const _banglaMonthNumbers = [
  9,
  10,
  11,
  12,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
];

/// Weekdays in Bangla
const banglaWeekdays = [
  "সোমবার",
  "মঙ্গলবার",
  "বুধবার",
  "বৃহস্পতিবার",
  "শুক্রবার",
  "শনিবার",
  "রবিবার",
];

/// English month to Bangla season conversion constants
const _gregEquivalentBanglaSeasons = [
  "শীত",
  "বসন্ত",
  "গ্রীষ্ম",
  "বর্ষা",
  "শরৎ",
  "হেমন্ত",
];

/// The last day of each Bangla month in the Gregorian calendar
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

/// Total days in each Bangla month
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

/// The index of the Bangla month that is affected by a leap year
const gregEquivalentLeapYearIndexInBanglaMonths = 2;

/// A class that represents a Bangla date.
class BanglaDate {
  /// The day of the month.
  final String day;

  /// The month of the year.
  final String month;

  /// The year.
  final String year;

  /// The name of the month.
  final String monthName;

  /// The day of the week.
  final String weekday;

  /// The season.
  final String season;

  /// Whether the year is a leap year.
  final bool isLeapYear;

  /// The full date string.
  final String date;

  /// Creates a new BanglaDate object.
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

  /// Creates a new BanglaDate object from an English date.
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

  /// Creates a new BanglaDate object from an English date string.
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
    if (month < 4 || (month == 4 && day < 14)) {
      banglaYear = year - 594;
    } else {
      banglaYear = year - 593;
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
    DateTime now = DateTime.now();
    year ??= now.year;
    month ??= now.month;
    day ??= now.day;

    final banglaDate = _calculateBanglaDate(year!, month!, day!);
    final banglaMonth = banglaDate['month'] as int;

    final banglaYear = _getBanglaYear(
      day: day,
      month: month,
      year: year,
    );
    final banglaWeekday = _getBanglaWeekday(
      day: day,
      month: month,
      year: year,
    );

    return {
      "weekday": banglaWeekday,
      "day": BanglaNumber.fromEnglish(banglaDate['day'] as int).value,
      "month": BanglaNumber.fromEnglish(_banglaMonthNumbers[banglaMonth]).value,
      "monthName": _gregEquivalentBanglaMonths[banglaMonth],
      "year": banglaYear,
      "season": _gregEquivalentBanglaSeasons[banglaMonth ~/ 2],
    };
  }

  static Map<String, int> _calculateBanglaDate(int year, int month, int day) {
    month = month - 1;

    int banglaDay;
    int banglaMonth;

    if (day <= _gregEquivalentLastDayOfBanglaMonths[month]) {
      int totalDaysInCurrentBanglaMonth = totalDaysInBanglaMonths[month];
      if (month == gregEquivalentLeapYearIndexInBanglaMonths &&
          _isLeapYear(year: year)) {
        totalDaysInCurrentBanglaMonth += 1;
      }
      banglaDay = totalDaysInCurrentBanglaMonth +
          day -
          _gregEquivalentLastDayOfBanglaMonths[month];
      banglaMonth = month;
    } else {
      banglaDay = day - _gregEquivalentLastDayOfBanglaMonths[month];
      banglaMonth = (month + 1) % 12;
    }

    return {'day': banglaDay, 'month': banglaMonth};
  }
}
