import 'package:grizzly_viz_scales/grizzly_viz_scales.dart';
import 'package:test/test.dart';

void main() {
	group('TimeScale', () {
		setUp(() {
		});

		test('ticks', () {
			final s1 = scaleTime([new DateTime(2016, 1, 1), new DateTime(2017, 1, 1)], [0, 120]);
			final Iterable<DateTime> ticks = s1.ticks(12);

			List<DateTime> expectedTicks = new List<DateTime>.generate(12, (i) => new DateTime(2016, i + 1, 1));

			expect(ticks, expectedTicks);
		});

		test('ticks.uneven.less', () {
			final s1 = scaleTime([new DateTime(2016, 1, 1), new DateTime(2017, 1, 1)], [0, 120]);
			final Iterable<DateTime> ticks = s1.ticks();

			List<DateTime> expectedTicks = new List<DateTime>.generate(12, (i) => new DateTime(2016, i + 1, 1));

			expect(ticks, expectedTicks);
		});

		test('ticks.uneven.more', () {
			final s1 = scaleTime([new DateTime(2016, 1, 1), new DateTime(2017, 1, 1)], [0, 120]);
			final Iterable<DateTime> ticks = s1.ticks(15);
			print(ticks.length);

			List<DateTime> expectedTicks = new List<DateTime>.generate(12, (i) => new DateTime(2016, i + 1, 1));

			print(ticks);

			//TODO expect(ticks, expectedTicks);
		});

		test('ticks.uneven.more', () {
			final s1 = scaleTime([new DateTime(2007, 4, 24), new DateTime(2012, 4, 24)], [0, 120]);
			final Iterable<DateTime> ticks = s1.ticks(10);
			print(ticks.length);

			List<DateTime> expectedTicks = new List<DateTime>.generate(12, (i) => new DateTime(2016, i + 1, 1));

			print(ticks);

			//TODO expect(ticks, expectedTicks);
		});
	});
}