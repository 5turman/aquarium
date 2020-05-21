import 'package:flutter/foundation.dart';

import 'fish.dart';

class FishIcon {
  const FishIcon._(
    this.assetName, {
    @required this.width,
    @required this.height,
  })  : assert(assetName != null),
        assert(width != null),
        assert(height != null);

  final String assetName;
  final double width;
  final double height;

  static FishIcon getIcon(FishType type) {
    return (type == FishType.herbivore) ? herbivoreIcon : predatorIcon;
  }

  static const herbivoreIcon =
      FishIcon._('images/herbivore.svg', width: 64, height: 56);

  static const predatorIcon =
      FishIcon._('images/predator.svg', width: 64, height: 48);
}
