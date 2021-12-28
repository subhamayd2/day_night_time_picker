import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// Render the [Ok] and [Cancel] buttons
class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final color =
        timeState.widget.accentColor ?? Theme.of(context).colorScheme.secondary;

    if (timeState.widget.isOnValueChangeMode) {
      return SizedBox(
        height: 8,
      );
    }

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: color),
            ),
            onPressed: timeState.onCancel,
            child: Text(
              timeState.widget.cancelText,
              style: timeState.widget.cancelStyle,
            ),
          ),
          TextButton(
            onPressed: timeState.onOk,
            child: Text(
              timeState.widget.okText,
              style: timeState.widget.okStyle,
            ),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
