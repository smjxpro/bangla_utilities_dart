/// Bangla (Bengali) numeral constants.
const List<String> _kBanglaDigits = [
  '০',
  '১',
  '২',
  '৩',
  '৪',
  '৫',
  '৬',
  '৭',
  '৮',
  '৯',
];

const int _kZeroCodeUnit = 48; // '0'.codeUnitAt(0)

/// Converts English (ASCII) numerals to their Bangla equivalents.
///
/// ```dart
/// final n = BanglaNumber.fromEnglish(1234);
/// print(n.value); // ১২৩৪
///
/// final s = BanglaNumber.fromString('Price: 42.5');
/// print(s.value); // Price: ৪২.৫
/// ```
class BanglaNumber {
  /// The Bangla numeral string.
  final String value;

  /// The original English integer (only valid when constructed via [fromEnglish]).
  final int? englishValue;

  const BanglaNumber._({required this.value, this.englishValue});

  /// Creates a [BanglaNumber] from an [int].
  ///
  /// All ASCII digits in the string representation of [number] are replaced
  /// with their Bangla counterparts.
  factory BanglaNumber.fromEnglish(int number) => BanglaNumber._(
        value: _convertDigits(number.toString()),
        englishValue: number,
      );

  /// Creates a [BanglaNumber] from an arbitrary [String].
  ///
  /// Every ASCII digit (`0`–`9`) in [source] is replaced with the
  /// corresponding Bangla digit. Other characters (letters, punctuation,
  /// whitespace, signs) are preserved as-is.
  ///
  /// ```dart
  /// BanglaNumber.fromString('2024-01-15').value // ২০২৪-০১-১৫
  /// ```
  factory BanglaNumber.fromString(String source) =>
      BanglaNumber._(value: _convertDigits(source));

  /// Replaces each ASCII digit in [s] with the corresponding Bangla digit
  /// using O(1) index arithmetic instead of a linear search.
  static String _convertDigits(String s) {
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final int codeUnit = s.codeUnitAt(i);
      if (codeUnit >= _kZeroCodeUnit && codeUnit <= _kZeroCodeUnit + 9) {
        buf.write(_kBanglaDigits[codeUnit - _kZeroCodeUnit]);
      } else {
        buf.write(s[i]);
      }
    }
    return buf.toString();
  }

  @override
  String toString() => value;
}
