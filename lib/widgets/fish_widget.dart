import 'dart:math';

import 'package:aquarium/models/fish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class FishWidget extends StatelessWidget {
  FishWidget(this.fish) : assert(fish != null);

  final Fish fish;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: fish.x,
      top: fish.y,
      child: Transform(
        alignment: Alignment.center,
        transform: (fish.direction > pi / 2 && fish.direction < 3 * pi / 2)
            ? Matrix4.rotationY(pi)
            : Matrix4.identity(),
        child: SvgPicture.asset(
          fish.icon.assetName,
          width: fish.width,
          height: fish.height,
        ),
      ),
    );
  }
}
