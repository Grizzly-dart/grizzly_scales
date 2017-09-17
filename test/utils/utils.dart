import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('utils', () {
    setUp(() {
    });

    test('binaryRangeSearch.evenLen', () {
      final ranges = [10, 20, 30, 40, 50, 60];
      expect(binaryRangeSearch(ranges, 5), 0);
      expect(binaryRangeSearch(ranges, 10), 0);
      expect(binaryRangeSearch(ranges, 20), 1);
      expect(binaryRangeSearch(ranges, 21), 1);
      expect(binaryRangeSearch(ranges, 30), 2);
      expect(binaryRangeSearch(ranges, 31), 2);
      expect(binaryRangeSearch(ranges, 40), 3);
      expect(binaryRangeSearch(ranges, 41), 3);
      expect(binaryRangeSearch(ranges, 50), 4);
      expect(binaryRangeSearch(ranges, 51), 4);
      expect(binaryRangeSearch(ranges, 60), 5);
      expect(binaryRangeSearch(ranges, 61), 5);
    });

    test('binaryRangeSearch.oddLen', () {
      final ranges = [10, 20, 30, 40, 50, 60, 70];
      expect(binaryRangeSearch(ranges, 5), 0);
      expect(binaryRangeSearch(ranges, 10), 0);
      expect(binaryRangeSearch(ranges, 20), 1);
      expect(binaryRangeSearch(ranges, 21), 1);
      expect(binaryRangeSearch(ranges, 30), 2);
      expect(binaryRangeSearch(ranges, 31), 2);
      expect(binaryRangeSearch(ranges, 40), 3);
      expect(binaryRangeSearch(ranges, 41), 3);
      expect(binaryRangeSearch(ranges, 50), 4);
      expect(binaryRangeSearch(ranges, 51), 4);
      expect(binaryRangeSearch(ranges, 60), 5);
      expect(binaryRangeSearch(ranges, 61), 5);
      expect(binaryRangeSearch(ranges, 70), 6);
      expect(binaryRangeSearch(ranges, 71), 6);
    });
  });
}
