# bangla_utilities

[![pub.dev](https://img.shields.io/pub/v/bangla_utilities.svg)](https://pub.dev/packages/bangla_utilities)
[![CI](https://github.com/smjxpro/bangla_utilities_dart/actions/workflows/ci.yml/badge.svg)](https://github.com/smjxpro/bangla_utilities_dart/actions/workflows/ci.yml)

A pure-Dart utility library for converting Gregorian dates to the **Bangla calendar** (বাংলা পঞ্জিকা), formatting them, and rendering numbers as **Bangla (Bengali) numerals**.

No Flutter dependency — works in any Dart environment (Flutter, server, CLI, web).

---

## Features

- 📅 **Bangla date** — day, month (name + numeral), year, weekday, season
- 🗓️ **Date formatting** — pattern-based formatting with Bangla numeral tokens
- 🔢 **Bangla numerals** — convert any `int` or digit-containing `String`
- 🌿 **Leap-year detection** (Gregorian)
- ✅ Zero external runtime dependencies

---

## Installation

```yaml
dependencies:
  bangla_utilities: ^2.0.2
```

```bash
dart pub get
```

---

## Usage

### BanglaDate

```dart
import 'package:bangla_utilities/bangla_utilities.dart';

// Today's date
final today = BanglaDate.today();
print(today.date);      // e.g. ১৯-১১-১৪৩১
print(today.monthName); // e.g. ফাল্গুন
print(today.weekday);   // e.g. বুধবার
print(today.season);    // e.g. বসন্ত
print(today.yearInt);   // e.g. 1431  (raw int)

// From a DateTime
final d = BanglaDate.fromDateTime(DateTime(2020, 5, 31));
print(d.date);      // ১৭-২-১৪২৭
print(d.monthName); // জ্যৈষ্ঠ
print(d.weekday);   // রবিবার

// From separate year / month / day components (all optional, default to today)
final d2 = BanglaDate.fromEnglishYearMonthDay(year: 2024, month: 4, day: 14);
print(d2.monthName); // বৈশাখ  (Pohela Boishakh)
print(d2.dayInt);    // 1

// From an ISO 8601 string
final d3 = BanglaDate.fromEnglishDate('2020-05-31');
print(d3.isLeapYear); // true
```

#### BanglaDate properties

| Property | Type | Description | Example |
|---|---|---|---|
| `day` | `String` | Bangla numeral day | `'১৭'` |
| `dayInt` | `int` | Day as integer | `17` |
| `month` | `String` | Bangla numeral month (1-based) | `'২'` |
| `monthInt` | `int` | Month as integer (বৈশাখ=1 … পৌষ=9 … চৈত্র=12) | `2` |
| `monthName` | `String` | Bangla month name | `'জ্যৈষ্ঠ'` |
| `year` | `String` | Bangla numeral year | `'১৪২৭'` |
| `yearInt` | `int` | Year as integer | `1427` |
| `weekday` | `String` | Bangla weekday name | `'রবিবার'` |
| `season` | `String` | Bangla season name | `'গ্রীষ্ম'` |
| `date` | `String` | Formatted `day-month-year` | `'১৭-২-১৪২৭'` |
| `isLeapYear` | `bool` | Whether Gregorian year is a leap year | `true` |

---

### BanglaDateFormatter

Format a `BanglaDate` using a pattern string with the following tokens:

| Token | Description | Example |
|---|---|---|
| `YYYY` | Full Bangla year | `১৪৩০` |
| `YY` | Last 2 Bangla digits of year | `৩০` |
| `MM` | Zero-padded 2-digit Bangla month | `০৯` |
| `M` | Bangla month without leading zero | `৯` |
| `DD` | Zero-padded 2-digit Bangla day | `০২` |
| `D` | Bangla day without leading zero | `২` |
| `d` | Bangla weekday name | `সোমবার` |
| `S` | Bangla season name | `শীত` |

```dart
import 'package:bangla_utilities/bangla_utilities.dart';

final date = BanglaDate.fromEnglishDate('2024-01-01');

const f1 = BanglaDateFormatter('DD/MM/YYYY');
print(f1.format(date)); // ১৮/০৯/১৪৩০

const f2 = BanglaDateFormatter('DD-MM-YY');
print(f2.format(date)); // ১৮-০৯-৩০

const f3 = BanglaDateFormatter('D/M/YYYY');
print(f3.format(date)); // ১৮/৯/১৪৩০

const f4 = BanglaDateFormatter('d, S');
print(f4.format(date)); // সোমবার, শীত
```

---

### BanglaNumber

```dart
import 'package:bangla_utilities/bangla_utilities.dart';

// From an int
final n = BanglaNumber.fromEnglish(1234);
print(n.value);        // ১২৩৪
print(n.englishValue); // 1234

// From an arbitrary string — non-digit characters are preserved
final s = BanglaNumber.fromString('2024-01-15');
print(s.value); // ২০২৪-০১-১৫

final price = BanglaNumber.fromString('Price: 42.5 BDT');
print(price.value); // Price: ৪২.৫ BDT
```

---

## Migration from v1.x

The old `BanglaUtility` static class was removed in v2.0.0. Replace usages as follows:

| Old (v1.x) | New (v2.x) |
|---|---|
| `BanglaUtility.getBanglaDate(...)` | `BanglaDate.fromEnglishYearMonthDay(...).date` |
| `BanglaUtility.getBanglaDay(...)` | `BanglaDate.fromEnglishYearMonthDay(...).day` |
| `BanglaUtility.getBanglaMonth(...)` | `BanglaDate.fromEnglishYearMonthDay(...).month` |
| `BanglaUtility.getBanglaMonthName(...)` | `BanglaDate.fromEnglishYearMonthDay(...).monthName` |
| `BanglaUtility.getBanglaYear(...)` | `BanglaDate.fromEnglishYearMonthDay(...).year` |
| `BanglaUtility.getBanglaWeekday(...)` | `BanglaDate.fromEnglishYearMonthDay(...).weekday` |
| `BanglaUtility.getBanglaSeason(...)` | `BanglaDate.fromEnglishYearMonthDay(...).season` |
| `BanglaUtility.isLeapYear(year: y)` | `BanglaDate.fromEnglishYearMonthDay(year: y).isLeapYear` |
| `BanglaUtility.englishToBanglaDigit(englishDigit: n)` | `BanglaNumber.fromEnglish(n).value` |

---

## License

MIT — see [LICENSE](LICENSE).
