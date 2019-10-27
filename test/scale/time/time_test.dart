import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('TimeScale', () {
    setUp(() {});

    test('ticks', () {
      final s1 = TimeScale([DateTime(2000, 1, 1), DateTime(2009, 1, 1)], [0, 9]);
      print(s1.ticks());
      /*
      final s1 =
          scaleTime([DateTime(2016, 1, 1), DateTime(2017, 1, 1)], [0, 120]);
      final Iterable<DateTime> ticks = s1.ticks(12);

      List<DateTime> expectedTicks =
          List<DateTime>.generate(12, (i) => DateTime(2016, i + 1, 1));

      expect(ticks, expectedTicks);
       */
    });

    test('ticks.uneven.less', () {
      /*
      final s1 =
          scaleTime([DateTime(2016, 1, 1), DateTime(2017, 1, 1)], [0, 120]);
      final Iterable<DateTime> ticks = s1.ticks();

      List<DateTime> expectedTicks =
          List<DateTime>.generate(12, (i) => DateTime(2016, i + 1, 1));

      expect(ticks, expectedTicks);
       */
    });

    test('ticks.uneven.more', () {
      /*
      final s1 =
          scaleTime([DateTime(2016, 1, 1), DateTime(2017, 1, 1)], [0, 120]);
      final Iterable<DateTime> ticks = s1.ticks(15);
      print(ticks.length);

      List<DateTime> expectedTicks =
          List<DateTime>.generate(12, (i) => DateTime(2016, i + 1, 1));

      print(ticks);

      //TODO expect(ticks, expectedTicks);
       */
    });

    test('ticks.uneven.more', () {
      /*
      final s1 =
          scaleTime([DateTime(2007, 4, 24), DateTime(2012, 4, 24)], [0, 120]);
      final Iterable<DateTime> ticks = s1.ticks(10);
      print(ticks.length);

      List<DateTime> expectedTicks =
          List<DateTime>.generate(12, (i) => DateTime(2016, i + 1, 1));

      print(ticks);

      //TODO expect(ticks, expectedTicks);
       */
    });
  });
}
