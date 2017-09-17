library vizzie.interpolate;

import 'dart:math' as math;

typedef Polater<T> = T Function(T t);

typedef PolaterBuilder<T> = Polater<T> Function(T a, T b);

abstract class Interpolate {
  static Polater<num> number(num a, num b) {
    return (num t) => a + ((b - a) * t);
  }

  static Polater<num> log(num a, num b) {
    if (a < 0) {
      return (num t) => -math.pow(-b, t) * math.pow(-a, 1 - t);
    }

    return (num t) => math.pow(b, t) * math.pow(a, 1 - t);
  }
}

abstract class Deinterpolate {
  static Polater<num> linear(num a, num b) =>
      b != a ? (num t) => (t - a) / (b - a) : (num x) => 0;

  static Polater<num> log(num a, num b) {
    b = math.log(b / a);
    if (b == 0 || b.isNaN) {
      return (num n) => b;
    }

    return (num x) => math.log(x / a) / b;
  }
}
