import 'dart:math';
import 'dart:ui';

import 'fish.dart';

void moveFishes(List<Fish> fishes, Size aquariumSize, double elapsedSeconds) {
  for (final fish in fishes) {
    final distance = elapsedSeconds * fish.speed;
    moveFish(fish, aquariumSize, distance);
  }
}

void moveFish(Fish fish, Size aquariumSize, double distance) {
  final dx = cos(fish.direction) * distance;
  final dy = sin(fish.direction) * distance;
  final left = fish.x + dx;
  final top = fish.y + dy;
  final right = left + fish.width;
  final bottom = top + fish.height;

  final aquariumWidth = aquariumSize.width;
  final aquariumHeight = aquariumSize.height;

  if (left < 0) {
    fish.x = 0;

    final random = Random();

    if (top < 0) {
      fish
        ..y = 0
        ..direction = random.nextDouble() * pi / 2;
      return;
    }
    if (bottom > aquariumHeight) {
      fish
        ..y = aquariumHeight - fish.height
        ..direction = -random.nextDouble() * pi / 2;
      return;
    }

    fish
      ..y = fish.y + dx * tan(fish.direction)
      ..direction = pi * (random.nextDouble() - 0.5);
    return;
  }

  if (right > aquariumWidth) {
    fish.x = aquariumWidth - fish.width;

    final random = Random();
    if (top < 0) {
      fish
        ..y = 0
        ..direction = pi / 2 * (random.nextDouble() + 1);
      return;
    }

    if (bottom > aquariumHeight) {
      fish
        ..y = aquariumHeight - fish.height
        ..direction = pi * (random.nextDouble() + 1);
      return;
    }

    fish
      ..y = fish.y + dx * tan(fish.direction)
      ..direction = pi * (random.nextDouble() + 0.5);
    return;
  }

  if (top < 0) {
    fish
      ..x = fish.x + dx / tan(fish.direction)
      ..y = 0
      ..direction = pi * Random().nextDouble();
    return;
  }

  if (bottom > aquariumHeight) {
    fish
      ..x = fish.x + dx / tan(fish.direction)
      ..y = aquariumHeight - fish.height
      ..direction = pi * (Random().nextDouble() + 1);
    return;
  }

  fish.x = left;
  fish.y = top;
}
