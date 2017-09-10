part of grizzly.viz.scales;

class IdentityNumeric<T> implements Numeric<T> {
  /// Converts `T` to `num`
  num toNum(T v) => v as num;

  /// Constructs `T` from `num`
  T fromNum(num v) => v as T;

  const IdentityNumeric();
}

/// Linear scale that operates on time
class TimeScale<RT> extends Scale<DateTime, RT> {
  final Continuous<int> _continuous;

  final Numeric<RT> rangeToNum;

  TimeScale(List<int> domain, List<RT> range,
      {this.rangeToNum: const IdentityNumeric()})
      : _continuous = new Continuous(
            domain,
            new List.generate(range.length, (i) => rangeToNum.toNum(range[i])),
            Deinterpolate.linear,
            Interpolate.number),
        domainDates = new UnmodifiableListView(new List.generate(domain.length,
            (i) => new DateTime.fromMillisecondsSinceEpoch(domain[i]))),
        rangeRT = new UnmodifiableListView(range);

  UnmodifiableListView<int> get domain => _continuous.domain;

  final UnmodifiableListView<RT> rangeRT;

  final UnmodifiableListView<DateTime> domainDates;

  UnmodifiableListView<num> get range => _continuous.range;

  RT scale(DateTime x) =>
      rangeToNum.fromNum(_continuous.scale(x.millisecondsSinceEpoch));

  DateTime invert(RT r) => new DateTime.fromMillisecondsSinceEpoch(
      _continuous.invert(rangeToNum.toNum(r)));

  RT scaleMs(int ms) => rangeToNum.fromNum(_continuous.scale(ms));

  TimeScale<RT> nice([int count = 10]) {
    num start = domain.first;
    num stop = domain.last;

    final bool isReverse = stop < start;

    if (isReverse) {
      final temp = start;
      start = stop;
      stop = temp;
    }

    final int target = (stop - start) ~/ count;
    final int index = binaryRangeSearch(_scaleTargets, target);

    final TimeRange ranger =
        index == 0 ? Ranger.millisecondsRange : _scaleRangers[index];

    return niceByTimeRanger(ranger);
  }

  TimeScale<RT> niceByTimeRanger(TimeRange ranger) {
    num start = domain.first;
    num stop = domain.last;

    final bool isReverse = stop < start;

    List<DateTime> d = domainDates.toList();

    if (isReverse) {
      d[0] = ranger.ceil(d[0]);
      d[d.length - 1] = ranger.floor(d[d.length - 1]);
    } else {
      d[0] = ranger.floor(d[0]);
      d[d.length - 1] = ranger.ceil(d[d.length - 1]);
    }

    List<RT> r = rangeRT;
    r[0] = scale(d[0]);
    r[r.length - 1] = scale(d[r.length - 1]);

    return new TimeScale<RT>(d.map((t) => t.millisecondsSinceEpoch), r,
        rangeToNum: rangeToNum);
  }

  Iterable<DateTime> ticks([int count = 10]) {
    if (count == 0) return <DateTime>[];

    num start = domain.first;
    num stop = domain.last;

    final bool isReverse = stop < start;

    if (isReverse) {
      final temp = start;
      start = stop;
      stop = temp;
    }

    final int target = (stop - start) ~/ count;
    final int index = binaryRangeSearch(_scaleTargets, target);

    TimeRange ranger = _scaleRangers[index];
    num steps = _scaleSteps[index];

    if (index == _scaleSteps.length) {
      steps = Ranger.tickStep(
          start / millisecondsPerYear, stop / millisecondsPerYear, count);
    } else if (index == 0) {
      steps = Ranger.tickStep(start, stop, count);
      ranger = Ranger.millisecondsRange;
    } else {
      final diff0 = target / _scaleTargets[index];
      final diff1 = _scaleTargets[index + 1] / target;

      if (diff1 < diff0) {
        ranger = _scaleRangers[index + 1];

      }
    }

    final ticks = ranger.range(domainDates.first, domainDates.last, steps);

    return isReverse ? ticks.reversed : ticks;
  }

  Iterable<DateTime> ticksByTimeRanger(TimeRange ranger, [int skip = 0]) {
    num start = domain.first;
    num stop = domain.last;

    final bool isReverse = stop < start;

    if (isReverse) {
      final temp = start;
      start = stop;
      stop = temp;
    }

    final ticks = ranger.range(domainDates.first, domainDates.last, skip);

    return isReverse ? ticks.reversed : ticks;
  }

  static String _threeDigits(int number) {
    String ret = number.toString();

    ret = '0' * (3 - ret.length) + ret;

    return ret;
  }

  DomainFormatter<DateTime> tickFormatter() => (DateTime date) {
        if (date.microsecond > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year} T '
              '${date.hour}:${date.minute}:${date.second}.'
              '${_threeDigits(date.millisecond)}${_threeDigits(date.microsecond)}';
        } else if (date.millisecond > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year} T '
              '${date.hour}:${date.minute}:${date.second}.${_threeDigits(date.millisecond)}';
        } else if (date.second > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year} T '
              '${date.hour}:${date.minute}:${date.second}';
        } else if (date.minute > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year} T '
              '${date.hour}:${date.minute}';
        } else if (date.hour > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year} T '
              '${date.hour}';
        } else if (date.day > 0) {
          return '${date.day} ${_monthsShort[date.month - 1]} ${date.year}';
        } else if (date.month > 0) {
          return _monthsShort[date.month - 1] + ' ' + date.year.toString();
        } else {
          return date.year.toString();
        }
      };

  static final _scaleRangers = <TimeRange>[
    Ranger.secondsRange,
    Ranger.secondsRange,
    Ranger.secondsRange,
    Ranger.secondsRange,
    Ranger.minutesRange,
    Ranger.minutesRange,
    Ranger.minutesRange,
    Ranger.minutesRange,
    Ranger.hoursRange,
    Ranger.hoursRange,
    Ranger.hoursRange,
    Ranger.hoursRange,
    Ranger.daysRange,
    Ranger.daysRange,
    Ranger.weeksRange,
    Ranger.daysRange,
    Ranger.monthsRange,
    Ranger.monthsRange,
    Ranger.monthsRange,
    Ranger.yearsRange,
  ];

  static final _scaleSteps = <int>[
    1,
    5,
    15,
    30,
    1,
    5,
    15,
    30,
    1,
    3,
    6,
    12,
    1,
    2,
    1,
    15,
    1,
    3,
    6,
    1,
  ];

  static final _scaleTargets = <int>[
    new Duration(seconds: 1).inMilliseconds,
    new Duration(seconds: 5).inMilliseconds,
    new Duration(seconds: 15).inMilliseconds,
    new Duration(seconds: 30).inMilliseconds,
    new Duration(minutes: 1).inMilliseconds,
    new Duration(minutes: 5).inMilliseconds,
    new Duration(minutes: 15).inMilliseconds,
    new Duration(minutes: 30).inMilliseconds,
    new Duration(hours: 1).inMilliseconds,
    new Duration(hours: 3).inMilliseconds,
    new Duration(hours: 6).inMilliseconds,
    new Duration(hours: 12).inMilliseconds,
    new Duration(days: 1).inMilliseconds,
    new Duration(days: 2).inMilliseconds,
    new Duration(days: 7).inMilliseconds,
    new Duration(days: 15).inMilliseconds,
    new Duration(days: 30).inMilliseconds,
    new Duration(days: 90).inMilliseconds,
    new Duration(days: 180).inMilliseconds,
    new Duration(days: 365).inMilliseconds,
  ];

  static const List<String> _monthsShort = const <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  static final int millisecondsPerYear = new Duration(days: 365).inMilliseconds;
}

typedef DomainFormatter<DT> = String Function(DT);
