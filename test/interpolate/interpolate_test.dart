// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('LinearScale', () {
    final s1 = LinearInterpolator(10, 20);

    setUp(() {});

    test('LinearInterpolator.forward', () {
      expect(s1.interpolate(0.0), 10);
      expect(s1.interpolate(0.2), 12);
      expect(s1.interpolate(0.5), 15);
      expect(s1.interpolate(1.0), 20);
      expect(s1.interpolate(1.5), 25);
    });

    test('LinearInterpolator.reverse', () {
      expect(s1.deinterpolate(10), 0.0);
      expect(s1.deinterpolate(12), 0.2);
      expect(s1.deinterpolate(15), 0.5);
      expect(s1.deinterpolate(20), 1.0);
      expect(s1.deinterpolate(25), 1.5);
    });
  });
}
