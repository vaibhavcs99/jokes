import 'dart:core';

import 'package:flutter/foundation.dart';

class Jokes {
  String type;
  String setup;
  String punchline;

  Jokes({
    @required this.type,
    @required this.setup,
    @required this.punchline,
  });
}
