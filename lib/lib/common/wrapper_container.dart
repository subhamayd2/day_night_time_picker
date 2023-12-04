import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// Just a simple [Container] with common styling
class WrapperContainer extends StatelessWidget {
  /// The child [Widget] to render
  final Widget child;

  /// Constructor for the [Widget]
  const WrapperContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeState = TimeModelBinding.of(context);
    double height = timeState.widget.height;
    Color backgroundColor = timeState.widget.backgroundColor;
    return Expanded(
      child: Container(
        height: height,
        color: backgroundColor,
        padding: timeState.widget.contentPadding,
        child: child,
      ),
    );
  }
}
