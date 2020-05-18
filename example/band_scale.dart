import 'dart:core';

import 'package:grizzly_scales/grizzly_scales.dart';

void main() {
  final scale = BandScale(['2019-01-01', '2019-02-01', '2019-03-01'], [0, 100],
      margin: 0.1, align: 0.5, padding: 0.1);
  print(scale.size);
  print(scale.scale('2019-01-01'));
  print(scale.scale('2019-02-01'));
  print(scale.scale('2019-03-01'));
}
