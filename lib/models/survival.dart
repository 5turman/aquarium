import 'dart:collection';
import 'dart:math';

import 'aquarium.dart';
import 'fish.dart';

void survive(List<Fish> fishes, Queue<Duration> birthTimeouts) {
  if (fishes.length <= 1) return;

  fishes.sort(_byAggressionAndSizeDesc);

  for (var i = 0; i < fishes.length - 1; ++i) {
    final f1 = fishes[i];
    if (f1.isPredator()) {
      for (var j = fishes.length - 1; j > i; --j) {
        final f2 = fishes[j];
        if (f1.intersectsWith(f2) && f1.canEat(f2)) {
          fishes.removeAt(j);
          birthTimeouts.add(birthTimeout);
        }
      }
    } else {
      break;
    }
  }
}

int _byAggressionAndSizeDesc(Fish f1, Fish f2) {
  if (f1.isPredator()) {
    if (f2.isPredator()) {
      return -f1.compareBySize(f2);
    }
    return -1;
  }
  if (f2.isPredator()) {
    return 1; // f1 > f2 and f2 comes first
  }
  return -f1.compareBySize(f2);
}

extension on Fish {
  bool isPredator() => (type == FishType.predator);

  int compareBySize(Fish other) {
    return size.index - other.size.index;
  }

  bool intersectsWith(Fish other) {
    final left = max(x, other.x);
    final top = max(y, other.y);
    final right = min(x + width, other.x + other.width);
    final bottom = min(y + height, other.y + other.height);

    return (right - left >= 0) && (bottom - top >= 0);
  }

  bool canEat(Fish other) {
    assert(isPredator());
    return (size.index >= other.size.index - 1);
  }
}
