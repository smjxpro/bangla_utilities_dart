import 'package:test/test.dart';

import 'package:bangla_utilities/bangla_utilities.dart';

void main() {
  // ── BanglaNumber ──────────────────────────────────────────────────────────

  group('BanglaNumber', () {
    group('fromEnglish', () {
      test('single digit', () {
        expect(BanglaNumber.fromEnglish(5).value, '৫');
      });

      test('multi-digit number', () {
        expect(BanglaNumber.fromEnglish(1234).value, '১২৩৪');
      });

      test('zero', () {
        expect(BanglaNumber.fromEnglish(0).value, '০');
      });

      test('stores englishValue', () {
        expect(BanglaNumber.fromEnglish(42).englishValue, 42);
      });

      test('toString() delegates to value', () {
        expect(BanglaNumber.fromEnglish(7).toString(), '৭');
      });
    });

    group('fromString', () {
      test('converts digits in plain number string', () {
        expect(BanglaNumber.fromString('2024').value, '২০২৪');
      });

      test('preserves non-digit characters', () {
        expect(BanglaNumber.fromString('2024-01-15').value, '২০২৪-০১-১৫');
      });

      test('handles decimal numbers', () {
        expect(BanglaNumber.fromString('3.14').value, '৩.১৪');
      });

      test('handles mixed text and digits', () {
        expect(BanglaNumber.fromString('Price: 42 BDT').value, 'Price: ৪২ BDT');
      });

      test('empty string returns empty', () {
        expect(BanglaNumber.fromString('').value, '');
      });

      test('no digits — string unchanged', () {
        expect(BanglaNumber.fromString('বাংলা').value, 'বাংলা');
      });

      test('englishValue is null for fromString', () {
        expect(BanglaNumber.fromString('42').englishValue, isNull);
      });
    });
  });

  // ── BanglaDate ────────────────────────────────────────────────────────────

  group('BanglaDate', () {
    // Reference date: 31 May 2020 == 17 Joishtho 1427 (Sunday)
    final BanglaDate ref = BanglaDate.fromEnglishYearMonthDay(
      year: 2020,
      month: 5,
      day: 31,
    );

    group('fromEnglishYearMonthDay — reference date 31 May 2020', () {
      test('day', () => expect(ref.day, '১৭'));
      test('dayInt', () => expect(ref.dayInt, 17));
      test('month', () => expect(ref.month, '৫'));
      test('monthInt', () => expect(ref.monthInt, 5));
      test('year', () => expect(ref.year, '১৪২৭'));
      test('yearInt', () => expect(ref.yearInt, 1427));
      test('monthName', () => expect(ref.monthName, 'জ্যৈষ্ঠ'));
      test('weekday', () => expect(ref.weekday, 'রবিবার'));
      test('season', () => expect(ref.season, 'গ্রীষ্ম'));
      test('date getter', () => expect(ref.date, '১৭-৫-১৪২৭'));
      test('isLeapYear', () => expect(ref.isLeapYear, true));
    });

    group('fromEnglishDate', () {
      test('parses ISO 8601 string', () {
        final BanglaDate d = BanglaDate.fromEnglishDate('2020-05-31');
        expect(d.date, '১৭-৫-১৪২৭');
      });
    });

    group('fromDateTime', () {
      test('equivalent to fromEnglishYearMonthDay', () {
        final BanglaDate d = BanglaDate.fromDateTime(DateTime(2020, 5, 31));
        expect(d.date, '১৭-৫-১৪২৭');
      });
    });

    group('today', () {
      test('returns a valid BanglaDate without throwing', () {
        expect(BanglaDate.today, returnsNormally);
      });
    });

    group('isLeapYear', () {
      test('2020 is a leap year', () {
        final BanglaDate d = BanglaDate.fromEnglishYearMonthDay(year: 2020);
        expect(d.isLeapYear, true);
      });

      test('2010 is not a leap year', () {
        final BanglaDate d = BanglaDate.fromEnglishYearMonthDay(year: 2010);
        expect(d.isLeapYear, false);
      });

      test('2000 is a leap year (divisible by 400)', () {
        final BanglaDate d = BanglaDate.fromEnglishYearMonthDay(year: 2000);
        expect(d.isLeapYear, true);
      });

      test('1900 is NOT a leap year (divisible by 100, not 400)', () {
        final BanglaDate d = BanglaDate.fromEnglishYearMonthDay(year: 1900);
        expect(d.isLeapYear, false);
      });
    });

    group('edge cases', () {
      test('1 January (first day of year — in পৌষ)', () {
        final BanglaDate d =
            BanglaDate.fromEnglishYearMonthDay(year: 2020, month: 1, day: 1);
        expect(d.monthName, 'পৌষ');
      });

      test('31 December (last day of year — in পৌষ)', () {
        final BanglaDate d =
            BanglaDate.fromEnglishYearMonthDay(year: 2020, month: 12, day: 31);
        expect(d.monthName, 'পৌষ');
      });

      test('14 March (leap year) — ফাল্গুন gets extra day', () {
        // In a leap year ফাল্গুন has 31 days; 14 March is still ফাল্গুন.
        final BanglaDate d =
            BanglaDate.fromEnglishYearMonthDay(year: 2020, month: 3, day: 14);
        expect(d.monthName, 'ফাল্গুন');
      });

      test('14 April (Pohela Boishakh) — 1st Baisakh', () {
        final BanglaDate d =
            BanglaDate.fromEnglishYearMonthDay(year: 2020, month: 4, day: 14);
        expect(d.monthName, 'বৈশাখ');
        expect(d.dayInt, 1);
      });
    });
  });
}
