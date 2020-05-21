import 'package:aquarium/models/aquarium.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'fish_widget.dart';

class AquariumWidget extends StatefulWidget {
  AquariumWidget(this.aquarium) : assert(aquarium != null);

  final Aquarium aquarium;

  @override
  _AquariumWidgetState createState() => _AquariumWidgetState();
}

class _AquariumWidgetState extends State<AquariumWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Ticker _ticker;

  Duration _lastElapsed = const Duration();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_update);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_ticker.isActive) {
        _ticker.start();
      }
    } else if (state == AppLifecycleState.inactive) {
      _ticker.stop();
      _lastElapsed = const Duration();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.aquarium.size = MediaQuery.of(context).size;

    final fishes = widget.aquarium.fishes;

    return Container(
      color: Colors.lightBlue,
      child: Stack(
        children: [
          for (var f in fishes) FishWidget(f),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _update(Duration elapsed) {
    setState(() {
      widget.aquarium.tick(elapsed - _lastElapsed);
      _lastElapsed = elapsed;
    });
  }
}
