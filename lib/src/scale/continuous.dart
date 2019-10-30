part of grizzly.viz.scales;

/// Continuous scales map a continuous, quantitative input domain to a continuous
/// output range.
class Continuous<DT extends num> extends Scale<DT, num> {
  final Iterable<DT> domain;

  final Iterable<num> range;

  List<Extent<DT>> _domainExtents;

  List<Extent<num>> _rangeExtents;

  final InterpolatorBuilder<num> interpolator;

  Continuous(List<DT> domain, List<num> range, this.interpolator)
      : range = range.toList(),
        domain = domain.toList() {
    if (this.domain.length != this.range.length)
      throw Exception('Domain and range must be of same length!');

    if (this.domain.length < 2)
      throw Exception('range and domain must have atleast two elements!');

    _domainExtents = Extent.consecutive(domain);
    _rangeExtents = Extent.consecutive(range);
  }

  num scale(DT x) {
    final extentIndex = Extent.search(_domainExtents, x);
    if (extentIndex == -1)
      throw ArgumentError('$x out of bounds of domian $domain');

    Extent<DT> d = _domainExtents[extentIndex];
    Extent<num> r = _rangeExtents[extentIndex];

    if (d.isDescending) {
      d = d.inverted;
      r = r.inverted;
    }

    return LinearInterpolator(r.lower, r.upper)
        .interpolate(interpolator(d.lower, d.upper).deinterpolate(x));
  }

  DT invert(num x) {
    final extentIndex = Extent.search(_rangeExtents, x);
    if (extentIndex == -1) throw ArgumentError('Out of bounds');

    Extent<DT> d = _domainExtents[extentIndex];
    Extent<num> r = _rangeExtents[extentIndex];

    if (d.isDescending) {
      d = d.inverted;
      r = r.inverted;
    }

    final i = LinearInterpolator(r.lower, r.upper).deinterpolate(x);
    final ret = interpolator(d.lower, d.upper).interpolate(i);
    return ret;
  }

  Iterable<DT> ticks({int count = 10}) =>
      ranger.ticks(domain.first, domain.last, count).cast<DT>();
}

/// Linear scales are a good default choice for continuous quantitative data
/// because they preserve proportional differences.
class LinearScale<DT extends num> extends Continuous<DT>
    implements Scale<DT, num> {
  LinearScale(List<DT> domain, List<num> range)
      : super(domain, range, (a, b) => LinearInterpolator(a, b));
}
