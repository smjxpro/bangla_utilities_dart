## 2.0.0

**Breaking changes:**
* Removed deprecated `BanglaUtility` class — use `BanglaDate` and `BanglaNumber` directly.
* Module-level constants `banglaWeekdays`, `totalDaysInBanglaMonths`, and
  `gregEquivalentLeapYearIndexInBanglaMonths` are now private (were accidentally public).
* Minimum Dart SDK bumped to `^3.4.0`.

**New features:**
* `BanglaDate.today()` — convenience constructor for today's date.
* `BanglaDate.fromDateTime(DateTime)` — construct directly from a `DateTime`.
* `BanglaDate.dayInt`, `monthInt`, `yearInt` — raw integer accessors alongside
  the existing Bangla numeral strings.
* `BanglaDate.date` is now a computed getter (no stored state).
* `BanglaNumber.fromString(String)` — converts digits in an arbitrary string
  (decimals, timestamps, mixed text).
* `BanglaNumber.englishValue` — stores the original `int` when constructed via
  `fromEnglish`.

**Performance:**
* `BanglaNumber` digit conversion switched from O(n) `indexOf` to O(1) code-unit
  arithmetic.
* `DateTime.now()` is resolved once per factory call instead of once per helper.

**Quality:**
* Switched dev lint rule set from `flutter_lints` to `lints` (pure-Dart package).
* Added GitHub Actions CI workflow (`analyze`, `format`, `test`).
* Comprehensive test suite with grouped tests and edge cases.

## 1.5.0



* Updated SDK
* Deprecated old API

## 1.0.0

* Migrated to sound null safety

## 0.2.1

* Added API documentation



## 0.2.0

* Added support for Web, Linux, MacOS and Windows
* Improved API 



## 0.1.1

* Added API documentations



## 0.0.1

##### initial release:

*  Added English to Bangla number converter
*  Added leap year checker
*  Added Bangla weekday, day, month, monthName, year and season