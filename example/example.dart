// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_scales/grizzly_scales.dart';

main() {
  // print(binaryRangeSearch([10, 20, 30, 40, 50, 60], 90));
  print(LinearScale([0, 1000], [0, 100]).ticks(count: 50));
}
