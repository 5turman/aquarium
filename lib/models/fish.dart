import 'dart:math';

import 'package:flutter/foundation.dart';

import 'fish_icons.dart';

enum FishSize { small, medium, big }
enum FishType { herbivore, predator }

/// speed in points per second
const _smallFishSpeed = 100;
const _scaleFactors = [1.0, 1.25, 1.5];

class Fish {
  factory Fish(FishType type, FishSize size) {
    assert(type != null);
    assert(size != null);

    final icon = FishIcon.getIcon(type);
    final speedFactor =
        _scaleFactors[(FishSize.values.length - 1 - size.index)].floor();
    return Fish._(type, size, icon,
        width: _scaleFactors[size.index] * icon.width,
        height: _scaleFactors[size.index] * icon.height,
        speed: speedFactor * _smallFishSpeed);
  }

  factory Fish.random() {
    final type = FishType.values.randomValue();
    final size = FishSize.values.randomValue();
    return Fish(type, size);
  }

  Fish._(
    this.type,
    this.size,
    this.icon, {
    @required this.width,
    @required this.height,
    @required this.speed,
  });

  final FishType type;
  final FishSize size;
  final FishIcon icon;
  final double width;
  final double height;

  /// speed in points per second
  final int speed;

  double x = 0;
  double y = 0;
  double direction = 0;
}

extension<T> on List<T> {
  T randomValue() {
    final index = Random().nextInt(length);
    return this[index];
  }
}
