part of grizzly.viz.scales;

typedef double _LogFunc(num d);

class LogScale<RT> implements Scale<double, RT> {
  final Continuous<double> _continuous;

  final Numeric<RT> rangeToNum;

  final double base;

  final _LogFunc _log;

  final _LogFunc _pow;

  LogScale(List<double> domain, List<RT> range,
      {this.base: 10.0, this.rangeToNum: const IdentityNumeric()})
      : _continuous = new Continuous(
            domain,
            new List.generate(range.length, (i) => rangeToNum.toNum(range[i])),
            Deinterpolate.log,
            Interpolate.log),
        rangeRT = new UnmodifiableListView(range),
        _log = makeLog(base),
        _pow = makePow(base);

  UnmodifiableListView<double> get domain => _continuous.domain;

  final UnmodifiableListView<RT> rangeRT;

  UnmodifiableListView<num> get range => _continuous.range;

  RT scale(double x) => rangeToNum.fromNum(x);

  double invert(RT r) => _continuous.invert(rangeToNum.toNum(r));

  Iterable<double> ticks([int count = 10]) {
    if (count == 0) return <double>[];

    num start = domain.first;
    num stop = domain.last;

    final bool isReverse = stop < start;

    if (isReverse) {
      final temp = start;
      start = stop;
      stop = temp;
    }

    double startLog = _log(start);
    double stopLog = _log(stop);

    List<double> ticks = new List<double>();

    if ((base % 1 == 0) && stopLog - startLog < count) {
      startLog = startLog.round() - 1.0;
      stopLog = stopLog.round() + 1.0;
      if (start > 0) {
        for (double c = startLog; c < stopLog; c++) {
          double p = _pow(c);
          for (int k = 1; k < base; ++k) {
            double t = p * k;
            if (t < start) continue;
            if (t > stop) break;
            ticks.add(t);
          }
        }
      } else {
        for (double c = startLog; c < stopLog; c++) {
          double p = _pow(c);
          for (double k = base - 1; k >= 1; --k) {
            double t = p * k;
            if (t < start) continue;
            if (t > stop) break;
            ticks.add(t);
          }
        }
      }
    } else {
      ticks = Ranger
          .ticks(startLog, stopLog, math.min(stopLog - startLog, count))
          .map(_pow)
          .toList();
    }

    return isReverse ? ticks.reversed : ticks;
  }

  DomainFormatter<double> tickFormatter(int count,
      {NumFormat format: const NumFormat()}) {
    //TODO
  }

  static double Function(double) makeLog(num base) {
    if (base == math.e) return math.log;
    final double d = math.log(base);
    return (num x) => math.log(x) / d;
  }

  static double Function(double) makePow(num base) {
    if (base == math.e) return math.exp;
    return (num x) => math.pow(base, x).toDouble();
  }
}
