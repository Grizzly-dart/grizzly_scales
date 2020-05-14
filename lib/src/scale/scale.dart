library grizzly.viz.scales;

import 'dart:math' as math;
import 'package:grizzly_range/grizzly_range.dart';
import 'package:grizzly_range/grizzly_range.dart' as ranger;

import '../interpolate/interpolate.dart';

export 'ordinal/band.dart';

part 'continuous.dart';
part 'log.dart';
part 'time.dart';

abstract class Scale<DT, RT> {
  Iterable<DT> get domain;

  Iterable<RT> get range;

  RT scale(DT t);

  DT invert(RT t);

  Iterable<DT> ticks({int count = 10});

  //TODO nice

  //TODO clone
}

/*
LogScale<RT> scaleLog<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return LogScale<RT>(domain, range, base: math.e, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLog2<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return LogScale<RT>(domain, range, base: 2.0, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLog10<RT>(List<double> domain, List<RT> range,
    {Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return LogScale<RT>(domain, range, base: 10.0, rangeToNum: rangeToNum);
}

LogScale<RT> scaleLogN<RT>(List<double> domain, List<RT> range,
    {double base: 10.0, Numeric<RT> rangeToNum: const IdentityNumeric()}) {
  return LogScale<RT>(domain, range, base: base, rangeToNum: rangeToNum);
}
 */

/*
TimeScale scaleTimeMs<RT>(List<num> domain, List<RT> range,
        {Numeric<RT> rangeToNum: const IdentityNumeric()}) =>
    TimeScale<RT>(domain, range, rangeToNum: rangeToNum);

TimeScale scaleTime<RT>(List<DateTime> domain, List<RT> range,
        {Numeric<RT> rangeToNum: const IdentityNumeric()}) =>
    TimeScale<RT>(
        domain.map((date) => date.millisecondsSinceEpoch).toList(), range,
        rangeToNum: rangeToNum);
 */

/// Converter between `T` and `num`
abstract class Numeric<T> {
  /// Converts `T` to `num`
  num toNum(T v);

  /// Constructs `T` from `num`
  T fromNum(num v);
}

class IdentityNumeric<T> implements Numeric<T> {
  /// Converts `T` to `num`
  num toNum(T v) => v as num;

  /// Constructs `T` from `num`
  T fromNum(num v) => v as T;

  const IdentityNumeric();
}

typedef DomainFormatter<DT> = String Function(DT);
