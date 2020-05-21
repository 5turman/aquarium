import 'package:flutter/cupertino.dart';

import 'models/aquarium.dart';
import 'widgets/aquarium_widget.dart';

void main() {
  runApp(MyApp(Aquarium(fishCount: 10)));
}

class MyApp extends StatelessWidget {
  MyApp(this.aquarium) : assert(aquarium != null);

  final Aquarium aquarium;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Aquarium',
      home: AquariumWidget(aquarium),
    );
  }
}
