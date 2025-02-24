import 'package:bangla_utilities/bangla_date.dart';
import 'package:bangla_utilities/bangla_number.dart';

/// The main class which contains static API methods
/// ```dart
/// BanglaUtility.someMethod(params)
/// ```
@Deprecated('Use BanglaDate or BanglaNumber instead')
class BanglaUtility {
  /// Returns Bangla equivalent of English digit
  /// ```dart
  /// BanglaUtility.englishToBanglaDigit(5) == '৫'
  /// ```
  @Deprecated('Use BanglaNumber instead')
  static String englishToBanglaDigit({required int englishDigit}) =>
      BanglaNumber.fromEnglish(englishDigit).value;

  /// Checks if given English year is a leap  year
  /// ```dart
  /// BanglaUtility.isLeapYear(2020) == true
  /// ```
  @Deprecated('Use BanglaDate instead')
  static bool isLeapYear({int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(year: year).isLeapYear;

  /// Returns Bangla year for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaYear(day:31, month:05, year: 2020) == '১৪২৭'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaYear({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).year;

  /// Returns Bangla weekday for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaWeekday(day:31, month:05, year: 2020) == 'রবিবার'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaWeekday({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).weekday;

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
  @Deprecated('Will be removed on next major version. Use BanglaDate instead')
  static Map<String, String> getBanglaDateMonthYearSeason({
    int? day,
    int? month,
    int? year,
  }) {
    var bangla = BanglaDate.fromEnglishYearMonthDay(
      day: day,
      month: month,
      year: year,
    );

    return {
      'weekday': bangla.weekday,
      'day': bangla.day,
      'month': bangla.month,
      'monthName': bangla.monthName,
      'year': bangla.year,
      'season': bangla.season,
    };
  }

  /// Returns Bangla day for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaDay(day:31, month:05, year: 2020) == '১৭'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaDay({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).day;

  /// Returns Bangla month for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaMonth(day:31, month:05, year: 2020) == '৫'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaMonth({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).month;

  /// Returns Bangla month name for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaMonthName(day:31, month:05, year: 2020) == 'জ্যৈষ্ঠ'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaMonthName({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).monthName;

  /// Returns Bangla season for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaSeason(day:31, month:05, year: 2020) == 'গ্রীষ্ম'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaSeason({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).season;

  /// Returns Bangla date for a given English date
  /// ```dart
  /// BanglaUtility.getBanglaDate(day:31, month:05, year: 2020) == '১৭-৫-১৪২৭'
  /// ```
  @Deprecated('Use BanglaDate instead')
  static String getBanglaDate({int? day, int? month, int? year}) =>
      BanglaDate.fromEnglishYearMonthDay(
        day: day,
        month: month,
        year: year,
      ).date;
}
