import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';

/// [Widget] for rendering the Sun and Moon Asset
class SunMoon extends StatelessWidget {
  /// Whether currently the Sun is displayed
  final bool? isSun;

  /// The Image asset for the sun
  final Image? sunAsset;

  /// The Image asset for the moon
  final Image? moonAsset;

  /// Initialize the Class
  SunMoon({
    this.isSun,
    this.sunAsset,
    this.moonAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SUN_MOON_WIDTH,
      child: AnimatedSwitcher(
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        duration: const Duration(milliseconds: 250),
        child: isSun!
            ? Container(
                key: const ValueKey(1),
                child: sunAsset ??
                    const Image(
                      image: AssetImage(
                        "packages/day_night_time_picker/assets/sun.png",
                      ),
                    ))
            : Container(
                key: const ValueKey(2),
                child: moonAsset ??
                    const Image(
                      image: AssetImage(
                          "packages/day_night_time_picker/assets/moon.png"),
                    ),
              ),
        transitionBuilder: (child, anim) {
          return ScaleTransition(
            scale: anim,
            child: FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: anim.drive(
                  Tween(
                    begin: const Offset(0, 4),
                    end: const Offset(0, 0),
                  ),
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
