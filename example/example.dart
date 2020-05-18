// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:grizzly_range/grizzly_range.dart';

void main() {
  // print(binaryRangeSearch([10, 20, 30, 40, 50, 60], 90));
  // print(LinearScale([0, 1000], [0, 100]).ticks(count: 50));

  final x =
      range(DateTime(2019, 11, 1), DateTime(2019, 11, 30), Duration(days: 1));
  print(x.toList());
  final xScale = TimeScale(Extent.compute(x).asList(), [0, 400]);
  print(xScale.ticks());
}
