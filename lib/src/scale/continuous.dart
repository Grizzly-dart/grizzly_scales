part of grizzly.viz.scales;

class Continuous implements Scale<num, num> {
  final UnmodifiableListView<num> domain;

  final UnmodifiableListView<num> range;

  final PolaterBuilder<num> deinterpolate;

  final PolaterBuilder<num> reinterpolate;

  //TODO final bool clamp;

  Polater<num> _scaler;

  Polater<num> _inverter;

  Continuous(
      List<num> domain, List<num> range, this.deinterpolate, this.reinterpolate)
      : range = new UnmodifiableListView<num>(range.toList()),
        domain = new UnmodifiableListView<num>(domain.toList()) {
    if (this.domain.length != this.range.length)
      throw new Exception('Domain and range must be of same length!');

    if ((this.domain.length < 2) || (this.range.length < 2))
      throw new Exception('range and domain must have atleast two elements!');

    _scaler = math.min(this.domain.length, this.range.length) > 2
        ? polymap(domain, range, deinterpolate, Interpolate.number)
        : bimap(domain.first, domain.last, range.first, range.last,
        deinterpolate, Interpolate.number);

    _inverter = math.min(this.domain.length, this.range.length) > 2
        ? polymap(range, domain, Deinterpolate.linear, reinterpolate)
        : bimap(range.first, range.last, domain.first, domain.last,
        Deinterpolate.linear, reinterpolate);
  }

  num scale(num x) => _scaler(x);

  num invert(num x) => _inverter(x);

  static Polater<num> bimap(num d0, num d1, num r0, num r1,
      PolaterBuilder<num> deinterpolater, PolaterBuilder<num> reinterpolater) {
    Polater<num> reinterpolate;
    Polater<num> deinterpolate;
    if (d1 < d0) {
      deinterpolate = deinterpolater(d1, d0);
      reinterpolate = reinterpolater(r1, r0);
    } else {
      deinterpolate = deinterpolater(d0, d1);
      reinterpolate = reinterpolater(r0, r1);
    }

    return (num t) => reinterpolate(deinterpolate(t));
  }

  static Polater<num> polymap(List<num> domain, List<num> range,
      PolaterBuilder<num> deinterpolater, PolaterBuilder<num> reinterpolater) {
    if (domain.length != range.length)
      throw new Exception('Domain and range must be of same length!');

    final int j = domain.length - 1;

    final d = new List<Polater<num>>.filled(j, null);
    final r = new List<Polater<num>>.filled(j, null);

    for (int i = 0; i < j; i++) {
      d[i] = deinterpolater(domain[i], domain[i + 1]);
      r[i] = reinterpolater(range[i], range[i + 1]);
    }

    return (num t) {
      int i = binaryRangeSearch(domain, t);
      if (i >= j) i = j - 1;
      return r[i](d[i](t));
    };
  }
}

class LinearScale extends Continuous implements Scale<num, num> {
  LinearScale(List<num> domain, List<num> range)
      : super(domain, range, Deinterpolate.linear, Interpolate.number);

  ticks([int count = 10]) {
    //TODO
  }
}