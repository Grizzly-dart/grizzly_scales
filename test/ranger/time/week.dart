import 'package:grizzly_viz_scales/grizzly_viz_scales.dart';
import 'package:test/test.dart';

void main() {
  group('Ranger.Weeks', () {
    setUp(() {});

    test('floor', () {
      DateTime date = new DateTime(2017, 9, 9, 1, 2, 3, 4, 5);
      expect(Ranger.weeksRange.floor(date), new DateTime(2017, 9, 3));
    });

    test('step', () {
      DateTime date = new DateTime(2017, 9, 9, 1, 2, 3, 4, 5);
      expect(Ranger.weeksRange.step(date, 1),
          new DateTime(2017, 9, 16, 1, 2, 3, 4, 5));
    });
  });
}
