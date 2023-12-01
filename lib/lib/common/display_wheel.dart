// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

/// Render the [Hour] or [Minute] wheel for `IOS` picker

class DisplayWheel extends StatelessWidget {
  /// [Controller] for the wheel
  final FixedExtentScrollController controller;

  /// The items rendered for the wheel
  final List<int?> items;

  /// The Change handler
  final Null Function(int value) onChange;

  /// Callback to render custom label
  final int Function(int item)? getModifiedLabel;

  /// Whether the wheel is selected or not
  final bool isSelected;

  /// Whether the wheel is disabled or not
  final bool disabled;

  /// Constructor for the [Widget]
  const DisplayWheel({
    Key? key,
    required this.controller,
    required this.items,
    required this.onChange,
    this.isSelected = false,
    this.disabled = false,
    this.getModifiedLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final _commonTimeStyles =
        Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 30,
            );

    final color =
        timeState.widget.accentColor ?? Theme.of(context).colorScheme.secondary;
    final unselectedColor = timeState.widget.unselectedColor ?? Colors.grey;

    return SizedBox(
      width: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 36,
          physics: disabled
              ? const NeverScrollableScrollPhysics()
              : const FixedExtentScrollPhysics(parent: BouncingScrollPhysics()),
          overAndUnderCenterOpacity: disabled ? 0 : 0.25,
          perspective: 0.01,
          magnification: timeState.widget.wheelMagnification,
          onSelectedItemChanged: onChange,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: items.length,
            builder: (context, index) {
              final val =
                  (getModifiedLabel?.call(items[index]!) ?? (items[index]!))
                      .toString()
                      .padLeft(2, '0');
              return Center(
                child: Text(
                  val,
                  textScaleFactor: 0.85,
                  style: _commonTimeStyles.copyWith(
                    color: isSelected ? color : unselectedColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
