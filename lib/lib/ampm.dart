import 'package:flutter/material.dart';

/// [Widget] for rendering the AM/PM button
class AmPm extends StatelessWidget {
  /// Currently selected by user
  final String? selected;

  /// [onChange] handler for AM/PM
  final void Function(String)? onChange;

  /// Accent color to be used for the button
  final Color? accentColor;

  /// Accent color to be used for the unselected button
  final Color? unselectedColor;

  /// Default [TextStyle]
  final _style = const TextStyle(fontSize: 20);

  /// Initialize the buttons
  AmPm({this.selected, this.onChange, this.accentColor, this.unselectedColor});

  @override
  Widget build(BuildContext context) {
    final isAm = selected == 'am';
    const unselectedOpacity = 0.5;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: !isAm
                  ? () {
                      onChange!("am");
                    }
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Opacity(
                  opacity: !isAm ? unselectedOpacity : 1,
                  child: Text(
                    "am",
                    style: _style.copyWith(
                      color: isAm ? accentColor : unselectedColor,
                      fontWeight: isAm ? FontWeight.bold : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isAm
                  ? () {
                      onChange!("pm");
                    }
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Opacity(
                  opacity: isAm ? unselectedOpacity : 1,
                  child: Text(
                    "pm",
                    style: _style.copyWith(
                      color: !isAm ? accentColor : unselectedColor,
                      fontWeight: !isAm ? FontWeight.bold : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
