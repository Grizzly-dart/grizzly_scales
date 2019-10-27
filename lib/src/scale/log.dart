part of grizzly.viz.scales;

typedef double _LogFunc(num d);

class LogScale implements Scale<double, num> {
  final Continuous<double> _continuous;

  final Numeric<double> domainToNum;

  final double base;

  final _LogFunc _log;

  final _LogFunc _pow;

  LogScale(List<double> domain, List<num> range,
      {this.base: 10.0, this.domainToNum: const IdentityNumeric()})
      : _continuous =
            Continuous(domain, range, (a, b) => LogInterpolator(a, b)),
        _log = makeLog(base),
        _pow = makePow(base);

  Iterable<double> get domain => _continuous.domain;

  Iterable<num> get range => _continuous.range;

  num scale(double x) => _continuous.scale(x);

  double invert(num r) => _continuous.invert(r);

  Iterable<double> ticks({int count = 10}) {
    if (count <= 0) return <double>[];

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

    var ticks = List<double>();

    if ((base % 1 == 0) && stopLog - startLog < count) {
      startLog = startLog.floorToDouble();
      stopLog = stopLog.ceilToDouble();
      if (start > 0) {
        for (double c = startLog; c < stopLog; c++) {
          double p = _pow(c);
          for (int k = 1; k < base; ++k) {
            double t = p * k;
            if (t < start) continue;
            if (t > stop) break;
            ticks.add(t);
            break;
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
      ticks = ranger
          .ticks(startLog, stopLog, math.min(stopLog - startLog, count))
          .map(_pow)
          .toList();
    }

    return isReverse ? ticks.reversed : ticks;
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
