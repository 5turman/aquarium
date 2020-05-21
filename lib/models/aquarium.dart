import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'creation.dart';
import 'fish.dart';
import 'movement.dart';
import 'survival.dart';

const birthTimeout = Duration(seconds: 15);

class Aquarium {
  Aquarium({@required this.fishCount}) : assert(fishCount != null);

  final int fishCount;

  Size _size;
  List<Fish> _fishes;
  Queue<Duration> _birthTimeouts = Queue<Duration>();

  // ignore: avoid_setters_without_getters
  set size(Size size) {
    assert(size != null);
    _size = size;
  }

  List<Fish> get fishes => _fishes ?? [];

  void tick(Duration elapsed) {
    if (_size == null) return;

    if (_fishes == null) {
      _fishes = buildFishes(fishCount, _size);
      return;
    }

    if (_birthTimeouts.isNotEmpty) {
      _birthTimeouts = Queue.from(_birthTimeouts.map((t) => t - elapsed));
      addFishesIfNeed(_fishes, _birthTimeouts, _size);
    }

    survive(_fishes, _birthTimeouts);

    final elapsedSeconds = elapsed.inMilliseconds / 1000.0;
    moveFishes(_fishes, _size, elapsedSeconds);
  }
}
