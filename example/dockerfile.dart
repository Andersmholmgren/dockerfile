// Copyright (c) 2015, Anders Holmgren. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dockerfile.example;

import 'package:dockerfile/dockerfile.dart';

main() {
  var awesome = new Awesome();
  print('awesome: ${awesome.isAwesome}');
}
