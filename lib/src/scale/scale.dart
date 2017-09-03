library grizzly.viz.scales;

import 'dart:collection';
import 'dart:math' as math;

import '../interpolate/interpolate.dart';

part 'continuous.dart';
part 'log.dart';
part 'time.dart';

abstract class Scale<DT, RT> {
  RT scale(DT t);

  DT invert(RT t);
}

LinearScale linear(List<num> domain, List<num> range) =>
    new LinearScale(domain, range);

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
