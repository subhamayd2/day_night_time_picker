import 'dart:math';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:day_night_time_picker/lib/utils.dart';
import 'package:flutter/material.dart';
import './sun_moon.dart';

/// [Widget] for rendering the box container of the sun and moon.
class DayNightBanner extends StatelessWidget {
  /// Get the background color of the container, representing the time of day
  Color? getColor(bool isDay, bool isDusk) {
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final hour = timeState.time.hour;
    final isDay = hour >= 6 && hour <= 18;
    final isDusk = hour >= 16 && hour <= 18;

    if (!timeState.widget.displayHeader!) {
      return Container(height: 25, color: Theme.of(context).cardColor);
    }

    final displace = mapRange(timeState.time.hour * 1.0, 0, 23);

    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      duration: const Duration(seconds: 1),
      height: 150,
      color: getColor(isDay, isDusk),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.round() - SUN_MOON_WIDTH;
          final top = sin(pi * displace) * 1.8;
          final left = maxWidth * displace;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.ease,
                child: SunMoon(
                  isSun: isDay,
                ),
                bottom: top * 20,
                left: left,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          );
        },
      ),
    );
  }
}
