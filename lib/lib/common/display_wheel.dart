import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

class DisplayWheel extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<int?> items;
  final Null Function(int value) onChange;
  final int Function(int item)? getModifiedLabel;
  final bool isSelected;
  final bool disabled;

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
    final _commonTimeStyles = Theme.of(context).textTheme.headline2!.copyWith(
          fontSize: 30,
        );

    final color =
        timeState.widget.accentColor ?? Theme.of(context).colorScheme.secondary;
    final unselectedColor = timeState.widget.unselectedColor ?? Colors.grey;

    return SizedBox(
      width: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 36,
          physics: disabled
              ? const NeverScrollableScrollPhysics()
              : const FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: disabled ? 0 : 0.25,
          perspective: 0.01,
          onSelectedItemChanged: onChange,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: items.length,
            builder: (context, index) {
              final val =
                  (getModifiedLabel?.call(items[index]!) ?? (items[index]!))
                      .toString()
                      .padLeft(2, "0");
              return Center(
                child: Text(
                  val,
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
