library grizzly.viz.scales;

import 'dart:math' as math;
import 'dart:collection';
import 'package:grizzly_primitives/grizzly_primitives.dart';

import '../interpolate/interpolate.dart';

part 'continuous.dart';
part 'log.dart';
part 'time.dart';

abstract class Scale<DT, RT> {
  RT scale(DT t);

  DT invert(RT t);

  Iterable<num> get range;

  Iterable<num> get domain;

  Iterable<DT> ticks([int count = 10]);

  //TODO nice

  //TODO clone
}

LinearScale scaleLinear(List<num> domain, List<num> range) =>
    new LinearScale(domain, range);

TimeScale scaleTimeMs<RT>(List<num> domain, List<RT> range,
        {Numeric<RT> rangeToNum: const IdentityNumeric()}) =>
    new TimeScale<RT>(domain, range, rangeToNum: rangeToNum);

TimeScale scaleTime<RT>(List<DateTime> domain, List<RT> range,
        {Numeric<RT> rangeToNum: const IdentityNumeric()}) =>
    new TimeScale<RT>(
        domain.map((date) => date.millisecondsSinceEpoch).toList(), range,
        rangeToNum: rangeToNum);

LogScale<RT> scaleLog<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return new LogScale<RT>(domain, range, base: math.e, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLog2<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return new LogScale<RT>(domain, range, base: 2.0, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLog10<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return new LogScale<RT>(domain, range, base: 10.0, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLogN<RT>(List<double> domain, List<RT> range,
    {double base: 10.0, Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return new LogScale<RT>(domain, range, base: base, rangeToNum: rangeToNum);
}

int binaryRangeSearch(List<num> list, final num search,
    {int start: 0, int end}) {
  if (end == null) end = list.length;

  while (start < end) {
    final int mid = (start + end) ~/ 2;
    if (mid == start) break;
    if (list[mid] > search)
      end = mid;
    else
      start = mid;
  }

  return start;
}

/// Converter between `T` and `num`
abstract class Numeric<T> {
  /// Converts `T` to `num`
  num toNum(T v);

  /// Constructs `T` from `num`
  T fromNum(num v);
}
