import 'dart:ui';

import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// Needed to use Backdrop filter conditionally, since `ImageFilter.blur`
/// was causing an issue in [web] when both the `sigma` values are `zero`
///
/// See https://github.com/flutter/flutter/issues/77258#issuecomment-822006335
class FilterWrapper extends StatelessWidget {
  /// child of the filter in the [Widget] tree
  final Widget? child;

  /// Constructor for the [Widget]
  const FilterWrapper({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final double blurAmount = timeState.widget.blurredBackground ? 5 : 0;

    if (blurAmount == 0.0) {
      return Container(
        child: child,
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
      child: child,
    );
  }
}
