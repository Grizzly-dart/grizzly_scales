import 'package:grizzly_range/grizzly_range.dart';

import '../scale.dart';

/// Band scales map a discrete domain to a set of bands within a continuous range.
/// The domain is specified using an array of values and the range is specified
/// using a 2-element array to define a continuous interval.
class BandScale<DT> implements Scale<DT, num> {
  final Iterable<DT> domain;

  final Iterable<num> range;

  final num padding;

  final num paddingAlign;

  final num margin;

  final num align;

  BandScale(Iterable<DT> domain, Iterable<num> range,
      {this.padding = 0, this.margin: 0, this.align: 0, this.paddingAlign: 0.5})
      : domain = domain.toList(),
        range = range.toList() {
    if (domain.isEmpty) throw ArgumentError('domain cannot be empty');
    if (range.length != 2)
      throw ArgumentError('range must contain exactly 2 items');
    if (padding < 0 || padding > 1)
      throw ArgumentError('padding should be between 0 and 1');
    if (margin < 0 || margin > 1)
      throw ArgumentError('margin should be between 0 and 1');
    if (align < 0 || align > 1)
      throw ArgumentError('align should be between 0 and 1');
  }

  num get step {
    num distance = (range.last - range.first).abs();
    distance = distance - 2 * margin * distance;
    if (distance.isNegative) return 0;
    return distance / domain.length;
  }

  num get size => step - (2 * padding * step);

  num bound(DT t) {
    final index = (domain as List).indexOf(t);
    if (index == -1) return null;
    num distance = (range.last - range.first).abs();
    return align * 2 * margin * distance +
        step * index +
        paddingAlign * 2 * padding * step;
  }

  num scale(DT t) {
    final start = bound(t);
    if (start == null) return null;
    return start + size / 2;
  }

  DT invert(num t) {
    final extent = Extent(range.first, range.last);
    if (!extent.has(t)) return null;
    num distance = (range.last - range.first).abs();
    num point = (t - range.first).abs();
    point = point - align * 2 * margin * distance;
    if (point.isNegative) return null;
    final index = point ~/ step;
    if (index >= domain.length) return null;
    return (domain as List)[index];
  }

  Iterable<DT> ticks({int count}) => domain;
}
