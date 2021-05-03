import 'dart:ui';

import 'package:flutter/material.dart';

/// Needed to use Backdrop filter conditionally, since `ImageFilter.blur`
/// was causing an issue in [web] when both the `sigma` values are `zero`
///
/// See https://github.com/flutter/flutter/issues/77258#issuecomment-822006335
class FilterWrapper extends StatelessWidget {
  /// The amount of blur to be applied to the backdrop
  final double blurAmount;

  /// child of the filter in the [Widget] tree
  final Widget? child;

  const FilterWrapper({
    Key? key,
    this.blurAmount = 0.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
