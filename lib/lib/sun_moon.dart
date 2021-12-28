import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// [Widget] for rendering the Sun and Moon Asset
class SunMoon extends StatelessWidget {
  /// Whether currently the Sun is displayed
  final bool? isSun;

  /// Initialize the Class
  SunMoon({
    this.isSun,
  });

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    return Container(
      width: SUN_MOON_WIDTH,
      child: AnimatedSwitcher(
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        duration: const Duration(milliseconds: 250),
        child: isSun!
            ? Container(
                key: const ValueKey(1),
                child: timeState.widget.sunAsset ??
                    const Image(
                      image: AssetImage(
                        "packages/day_night_time_picker/assets/sun.png",
                      ),
                    ))
            : Container(
                key: const ValueKey(2),
                child: timeState.widget.moonAsset ??
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
