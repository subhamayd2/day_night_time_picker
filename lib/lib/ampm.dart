import 'package:flutter/material.dart';

class AmPm extends StatelessWidget {
  final String selected;
  final void Function(String) onChange;
  final Color accentColor;

  final _style = TextStyle(fontSize: 20);

  AmPm({this.selected, this.onChange, this.accentColor});

  @override
  Widget build(BuildContext context) {
    final isAm = selected == 'am';
    final unselectedOpacity = 0.5;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: !isAm
                  ? () {
                      onChange("am");
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
                      color: isAm ? accentColor : null,
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
                      onChange("pm");
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
                      color: !isAm ? accentColor : null,
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
