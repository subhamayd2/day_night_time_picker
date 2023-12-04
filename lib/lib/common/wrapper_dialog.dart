import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// Just a simple [Dialog] with common styling
class WrapperDialog extends StatelessWidget {
  /// The child [Widget] to render
  final Widget child;

  /// Constructor for the [Widget]
  const WrapperDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final borderRadius = timeState.widget.borderRadius ?? BORDER_RADIUS;
    final elevation = timeState.widget.elevation ?? ELEVATION;
    final backgroundColor = timeState.widget.backgroundColor;

    return Dialog(
      insetPadding: timeState.widget.dialogInsetPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: IntrinsicHeight(
          child: child,
        ),
      ),
    );
  }
}
