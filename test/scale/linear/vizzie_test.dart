// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('LinearScale', () {
    setUp(() {
    });

    test('scale.bimap', () {
      final s1 = new LinearScale([0, 42], [0, 420]);
      expect(s1.scale(10), 100);
      expect(s1.scale(52), 520);

      expect(s1.invert(100), 10);
      expect(s1.invert(520), 52);
    });

    test('scale.polymap', () {
      final s1 = new LinearScale([10, 20, 30], [10, 20, 40]);
      expect(s1.scale(5), 5);
      expect(s1.scale(15), 15);
      expect(s1.scale(20), 20);
      expect(s1.scale(21), 22);
      expect(s1.scale(25), 30);
      expect(s1.scale(30), 40);
      expect(s1.scale(35), 50);

      expect(s1.invert(5), 5);
      expect(s1.invert(15), 15);
      expect(s1.invert(20), 20);
      expect(s1.invert(22), 21);
      expect(s1.invert(30), 25);
      expect(s1.invert(40), 30);
      expect(s1.invert(50), 35);
    });
  });
}
