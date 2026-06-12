# bangla_utilities

[![pub.dev](https://img.shields.io/pub/v/bangla_utilities.svg)](https://pub.dev/packages/bangla_utilities)
[![CI](https://github.com/smjxpro/bangla_utilities_dart/actions/workflows/ci.yml/badge.svg)](https://github.com/smjxpro/bangla_utilities_dart/actions/workflows/ci.yml)

A pure-Dart utility library for converting Gregorian dates to the **Bangla calendar** (বাংলা পঞ্জিকা) and rendering numbers as **Bangla (Bengali) numerals**.

No Flutter dependency — works in any Dart environment (Flutter, server, CLI, web).

---

## Features

- 📅 **Bangla date** — day, month (name + numeral), year, weekday, season
- 🔢 **Bangla numerals** — convert any `int` or digit-containing `String`
- 🗓️ **Leap-year detection** (Gregorian)
- ✅ Zero external runtime dependencies

---

## Installation

```yaml
dependencies:
  bangla_utilities: ^2.0.0
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
print(today.date);      // e.g. ১৯-২-১৪৩১
print(today.monthName); // e.g. ফাল্গুন
print(today.weekday);   // e.g. বুধবার
print(today.season);    // e.g. বসন্ত
print(today.yearInt);   // e.g. 1431  (raw int)

// From a DateTime
final d = BanglaDate.fromDateTime(DateTime(2020, 5, 31));
print(d.date);      // ১৭-৫-১৪২৭
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

| Property | Type | Example |
|---|---|---|
| `day` | `String` | `'১৭'` |
| `dayInt` | `int` | `17` |
| `month` | `String` | `'৫'` |
| `monthInt` | `int` | `5` |
| `monthName` | `String` | `'জ্যৈষ্ঠ'` |
| `year` | `String` | `'১৪২৭'` |
| `yearInt` | `int` | `1427` |
| `weekday` | `String` | `'রবিবার'` |
| `season` | `String` | `'গ্রীষ্ম'` |
| `date` | `String` | `'১৭-৫-১৪২৭'` |
| `isLeapYear` | `bool` | `true` |

---

### BanglaNumber

```dart
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

The old `BanglaUtility` static class has been removed. Replace usages as follows:

| Old (v1.x) | New (v2.0.0) |
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
