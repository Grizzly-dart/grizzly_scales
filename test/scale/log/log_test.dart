// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:test/test.dart';

void main() {
  group('LinearScale', () {
    final s1 = LogScale([1, 100000], [0, 500]);
    final s2 = LogScale([1, 10000000], [0, 500], base: 2);

    setUp(() {});

    test('scale.bimap', () {
      expect(s1.scale(1), 0);
      expect(s1.scale(10), 100);
      expect(s1.scale(100), 200);
      expect(s1.scale(1000), 300);
      expect(s1.scale(10000), 400);
      expect(s1.scale(100000), 500);

      expect(s1.invert(0), 1);
      expect(s1.invert(100).round(), 10);
      expect(s1.invert(200).round(), 100);
      expect(s1.invert(300).round(), 1000);
      expect(s1.invert(400).round(), 10000);
      expect(s1.invert(500).round(), 100000);
    });

    test('scale.ticks', () {
      expect(s1.ticks(count: 10), [1.0, 10.0, 100.0, 1000.0, 10000.0]);
      expect(s2.ticks(count: 10), [
        1.0,
        4.0,
        16.0,
        64.0,
        256.0,
        1024.0,
        4096.0,
        16384.0,
        65536.0,
        262144.0,
        1048576.0
      ]);
    });

    test('scale.polymap', () {
      /* TODO
      final s1 = LinearScale<num>([10, 20, 30], [10, 20, 40]);
      // expect(s1.scale(5), 5);
      expect(s1.scale(15), 15);
      expect(s1.scale(20), 20);
      expect(s1.scale(21), 22);
      expect(s1.scale(25), 30);
      expect(s1.scale(30), 40);
      // expect(s1.scale(35), 50);

      // expect(s1.invert(5), 5);
      expect(s1.invert(15), 15);
      expect(s1.invert(20), 20);
      expect(s1.invert(22), 21);
      expect(s1.invert(30), 25);
      expect(s1.invert(40), 30);
      // expect(s1.invert(50), 35);
       */
    });
  });
}
