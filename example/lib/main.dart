import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BanglaUtilitiesExampleApp());
}

class BanglaUtilitiesExampleApp extends StatelessWidget {
  const BanglaUtilitiesExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bangla Utilities Example',
      home: BanglaDatePage(),
    );
  }
}

class BanglaDatePage extends StatelessWidget {
  const BanglaDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BanglaDate today = BanglaDate.today();
    final BanglaDate historical =
        BanglaDate.fromDateTime(DateTime(2020, 5, 31));
    final BanglaNumber converted = BanglaNumber.fromEnglish(1234);
    final BanglaNumber fromStr = BanglaNumber.fromString('2024-01-15');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bangla Utilities Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's date in Bangla",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _Row('Date', today.date),
            _Row('Day', today.day),
            _Row('Month', today.month),
            _Row('Month name', today.monthName),
            _Row('Year', today.year),
            _Row('Weekday', today.weekday),
            _Row('Season', today.season),
            _Row('Leap year', today.isLeapYear.toString()),
            const Divider(height: 32),
            const Text(
              'Historical: 31 May 2020',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _Row('Date', historical.date),
            _Row('Month name', historical.monthName),
            _Row('Weekday', historical.weekday),
            const Divider(height: 32),
            const Text(
              'Number conversion',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _Row('1234 → Bangla', converted.value),
            _Row("'2024-01-15' → Bangla", fromStr.value),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
