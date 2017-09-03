library vizzie.interpolate;

typedef Polater<T> = T Function(T t);

typedef PolaterBuilder<T> = Polater<T> Function(T a, T b);

abstract class Interpolate {
  static Polater<num> number(num a, num b) {
    return (num t) => a + ((b - a) * t);
  }
}

abstract class Deinterpolate {
  static Polater<num> linear(num a, num b) =>
      b != a ? (num t) => (t - a) / (b - a) : (num x) => 0;
}