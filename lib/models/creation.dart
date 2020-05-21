import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'fish.dart';

List<Fish> buildFishes(int fishCount, Size aquariumSize) {
  final fishes = <Fish>[];
  final random = Random();
  for (var i = 0; i < fishCount; ++i) {
    fishes.add(buildFish(random, aquariumSize));
  }
  return fishes;
}

Fish buildFish(Random random, Size aquariumSize) {
  final fish = Fish.random();
  return fish
    ..x = random.nextInt((aquariumSize.width - fish.width).floor()).toDouble()
    ..y = random.nextInt((aquariumSize.height - fish.height).floor()).toDouble()
    ..direction = random.nextDouble() * 2 * pi;
}

void addFishesIfNeed(
  List<Fish> fishes,
  Queue<Duration> birthTimeouts,
  Size aquariumSize,
) {
  while (birthTimeouts.isNotEmpty) {
    if (birthTimeouts.first <= const Duration()) {
      birthTimeouts.removeFirst();
      fishes.add(buildFish(Random(), aquariumSize));
    } else {
      break;
    }
  }
}
