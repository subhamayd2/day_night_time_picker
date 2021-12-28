import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

class DisplayValue extends StatelessWidget {
  final String value;
  final Null Function()? onTap;
  final bool isSelected;

  const DisplayValue({
    Key? key,
    required this.value,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeState = TimeModelBinding.of(context);
    final _commonTimeStyles = Theme.of(context).textTheme.headline2!.copyWith(
          fontSize: 62,
          fontWeight: FontWeight.bold,
        );

    final color =
        timeState.widget.accentColor ?? Theme.of(context).colorScheme.secondary;
    final unselectedColor = timeState.widget.unselectedColor ?? Colors.grey;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: InkWell(
          onTap: onTap,
          child: Text(
            value,
            textScaleFactor: 1.0,
            style: _commonTimeStyles.copyWith(
                color: isSelected ? color : unselectedColor),
          ),
        ),
      ),
    );
  }
}
