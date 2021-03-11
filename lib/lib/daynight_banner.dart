import 'dart:math';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import './sun_moon.dart';

/// [Widget] for rendering the box container of the sun and moon.
class DayNightBanner extends StatelessWidget {
  /// Current selected hour
  final int? hour;

  /// How much the Image is displaced from [left] based on the current hour
  final double displace;

  /// Image asset of the sun
  final Image? sunAsset;

  /// Image asset of the moon
  final Image? moonAsset;

  /// Initialize the container
  DayNightBanner({
    this.hour,
    this.displace = 0,
    this.sunAsset,
    this.moonAsset,
  });

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
    final isDay = hour! >= 6 && hour! <= 18;
    final isDusk = hour! >= 16 && hour! <= 18;
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
                  sunAsset: sunAsset,
                  moonAsset: moonAsset,
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
