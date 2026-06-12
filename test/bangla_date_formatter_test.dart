import 'package:bangla_utilities/bangla_date.dart';
import 'package:bangla_utilities/bangla_date_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('BanglaDateFormatter', () {
    test('formats a date correctly', () {
      final date = BanglaDate.fromEnglishDate('2024-01-01');
      const formatter = BanglaDateFormatter('DD/MM/YYYY');
      expect(formatter.format(date), '১৮/০৯/১৪৩০');
    });

    test('formats a date with different separators', () {
      final date = BanglaDate.fromEnglishDate('2024-01-01');
      const formatter = BanglaDateFormatter('DD-MM-YYYY');
      expect(formatter.format(date), '১৮-০৯-১৪৩০');
    });

    test('formats a date with day and month without leading zeros', () {
      final date = BanglaDate.fromEnglishDate('2024-01-01');
      const formatter = BanglaDateFormatter('D/M/YYYY');
      expect(formatter.format(date), '১৮/৯/১৪৩০');
    });

    test('formats a date with short year', () {
      final date = BanglaDate.fromEnglishDate('2024-01-01');
      const formatter = BanglaDateFormatter('DD/MM/YY');
      expect(formatter.format(date), '১৮/০৯/৩০');
    });

    test('formats a date with weekday and season', () {
      final date = BanglaDate.fromEnglishDate('2024-01-01');
      const formatter = BanglaDateFormatter('d, S');
      expect(formatter.format(date), 'সোমবার, শীত');
    });

    test('formats a date with single digit day', () {
      final date = BanglaDate.fromEnglishDate('2024-04-15');
      const formatter = BanglaDateFormatter('DD/MM/YYYY');
      expect(formatter.format(date), '০২/০১/১৪৩১');
    });
  });
}
