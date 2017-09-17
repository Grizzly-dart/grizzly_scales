// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('LinearScale', () {
    setUp(() {});

    test('Interpolate.number', () {
      final s1 = Interpolate.number(10, 20);
      expect(s1(0.0), 10);
      expect(s1(0.2), 12);
      expect(s1(0.5), 15);
      expect(s1(1.0), 20);
    });

    test('Deinterpolate.linear', () {
      final s1 = Deinterpolate.linear(10, 20);
      expect(s1(10), 0.0);
      expect(s1(12), 0.2);
      expect(s1(15), 0.5);
      expect(s1(20), 1.0);
    });
  });
}
