/// Bangla digits
const kBanglaNumber = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

/// English digits
const kEnglishNumber = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

/// A class that represents a Bangla number.
class BanglaNumber {
  /// The value of the number.
  final String value;

  /// Creates a new BanglaNumber object from an English number.
  BanglaNumber.fromEnglish(int number)
      : value = _englishToBanglaDigit(englishDigit: number);

  /// Returns Bangla equivalent of English digit
  /// ```dart
  /// BanglaUtility.englishToBanglaDigit(5) == '৫'
  /// ```
  static String _englishToBanglaDigit({required int englishDigit}) {
    String englishDigitStr = englishDigit.toString();
    String banglaDigit = "";
    for (int i = 0; i < englishDigitStr.length; i++) {
      if (kEnglishNumber.contains(englishDigitStr[i])) {
        banglaDigit +=
            kBanglaNumber[kEnglishNumber.indexOf(englishDigitStr[i])];
      } else {
        banglaDigit += englishDigitStr[i];
      }
    }
    return banglaDigit;
  }

  @override
  String toString() => value;
}
