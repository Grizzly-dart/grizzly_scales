library vizzie.interpolate;

import 'dart:math' as math;

typedef InterpolatorBuilder<T> = Interpolator<T> Function(T a, T b);

abstract class Interpolator<T> {
  T interpolate(T t);

  T deinterpolate(T t);
}

class LinearInterpolator implements Interpolator<num> {
  final num a;

  final num b;

  const LinearInterpolator(this.a, this.b);

  @override
  num interpolate(num t) => a + ((b - a) * t);

  @override
  num deinterpolate(num t) => b != a ? (t - a) / (b - a) : 0;
}

class LogInterpolator implements Interpolator<num> {
  final num a;

  final num b;

  const LogInterpolator(this.a, this.b);

  @override
  num interpolate(num t) {
    if (a < 0) return -math.pow(-b, t) * math.pow(-a, 1 - t);
    return math.pow(b, t) * math.pow(a, 1 - t);
  }

  @override
  num deinterpolate(num t) {
    num b = math.log(this.b / a);

    if (b == 0 || b.isNaN) return b;
    return math.log(t / a) / b;
  }
}
