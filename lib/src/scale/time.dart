part of grizzly.viz.scales;

class TimeScale extends Scale<DateTime, num> {
  Continuous<int> _continuous;

  final Iterable<DateTime> domain;

  final Iterable<num> range;

  TimeScale(this.domain, this.range) {
    _continuous = Continuous<int>(
        domain.map((d) => d.microsecondsSinceEpoch).toList(),
        range,
        (a, b) => LinearInterpolator(a, b));
  }

  num scale(DateTime x) => _continuous.scale(x.millisecondsSinceEpoch);

  DateTime invert(num r) =>
      DateTime.fromMillisecondsSinceEpoch(_continuous.invert(r));

  Iterable<DateTime> ticks({int count = 10}) {
    // TODO nice bounds
    // TODO nice intervals

    Duration dur = domain.first.difference(domain.last);
    if (dur.isNegative) dur = -dur;
    dur = Duration(microseconds: dur.inMicroseconds ~/ count);

    if (dur > Duration(days: 200)) {
      int months = (dur.inDays / 365).ceil() * 12;
      if (months > 12000000) {
        months = months ~/ 1000000;
      } else if (months > 12000) {
        months = months ~/ 1000;
      } else if (months > 1200) {
        months = months ~/ 100;
      } else if (months > 120) {
        months = months ~/ 10;
      }
      return MonthRange(domain.first, domain.last, months).toList();
    } else if (dur > Duration(days: 90)) {
      int months = (dur.inDays / 180).ceil() * 6;
      return MonthRange(domain.first, domain.last, months).toList();
    } else if (dur > Duration(days: 30)) {
      return MonthRange(domain.first, domain.last, dur.inDays ~/ 30).toList();
    } else if (dur > Duration(days: 1)) {
      return TimeRange.d(domain.first, domain.last, dur.inDays).toList();
    } else if (dur > Duration(days: 1)) {
      return TimeRange.d(domain.first, domain.last, dur.inDays).toList();
    } else if (dur > Duration(hours: 1)) {
      return TimeRange.h(domain.first, domain.last, dur.inHours).toList();
    } else if (dur > Duration(minutes: 1)) {
      return TimeRange.m(domain.first, domain.last, dur.inMinutes).toList();
    } else if (dur > Duration(seconds: 1)) {
      return TimeRange.s(domain.first, domain.last, dur.inSeconds).toList();
    } else if (dur > Duration(milliseconds: 1)) {
      return TimeRange.s(domain.first, domain.last, dur.inMilliseconds)
          .toList();
    } else {
      return TimeRange.s(domain.first, domain.last, dur.inMilliseconds)
          .toList();
    }
  }
}
