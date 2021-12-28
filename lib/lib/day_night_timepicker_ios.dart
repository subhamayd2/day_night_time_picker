import 'package:day_night_time_picker/lib/common/action_buttons.dart';
import 'package:day_night_time_picker/lib/common/display_wheel.dart';
import 'package:day_night_time_picker/lib/common/wrapper_Dialog.dart';
import 'package:day_night_time_picker/lib/common/wrapper_container.dart';
import 'package:day_night_time_picker/lib/common/filter_wrapper.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';
import 'ampm.dart';
import 'daynight_banner.dart';
import 'utils.dart';

/// Private class. [StatefulWidget] that renders the content of the picker.
// ignore: must_be_immutable
class DayNightTimePickerIos extends StatefulWidget {
  @override
  _DayNightTimePickerIosState createState() => _DayNightTimePickerIosState();
}

/// Picker state class
class _DayNightTimePickerIosState extends State<DayNightTimePickerIos> {
  TimeModelBindingState? timeState;

  /// Controller for `hour` list
  FixedExtentScrollController? _hourController;

  /// Controller for `minute` list
  FixedExtentScrollController? _minuteController;

  /// List of hours to show
  List<int?> hours = [];

  /// List of minutes to show
  List<int?> minutes = [];

  void init() {
    final hourDiv =
        ((timeState!.widget.maxHour! - timeState!.widget.minHour!) + 1).round();
    final _hours = generateHours(
      hourDiv,
      timeState!.widget.minHour,
      timeState!.widget.maxHour,
    );

    double minMinute = getMinMinute(
        timeState!.widget.minMinute, timeState!.widget.minuteInterval);
    double maxMinute = getMaxMinute(
        timeState!.widget.maxMinute, timeState!.widget.minuteInterval);

    int minDiff = (maxMinute - minMinute).round();
    final minuteDiv =
        getMinuteDivisions(minDiff, timeState!.widget.minuteInterval);
    List<int?> _minutes = generateMinutes(
      minuteDiv,
      timeState!.widget.minuteInterval,
      minMinute,
      maxMinute,
    );

    final h = timeState!.widget.is24HrFormat
        ? timeState!.time.hour
        : timeState!.time.hourOfPeriod;

    final m = timeState!.time.minute;

    _hourController =
        FixedExtentScrollController(initialItem: _hours.indexOf(h))
          ..addListener(() {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              timeState!.onHourIsSelectedChange(true);
            });
          })
          ..addListener(() {
            _hourController!.position.isScrollingNotifier.addListener(() {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (timeState!.widget.isOnValueChangeMode &&
                    !_hourController!.position.isScrollingNotifier.value) {
                  timeState!.onOk();
                }
              });
            });
          });
    _minuteController =
        FixedExtentScrollController(initialItem: _minutes.indexOf(m))
          ..addListener(() {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              timeState!.onHourIsSelectedChange(false);
              setState(() {
                hours = _hours;
                minutes = _minutes;
              });
            });
          })
          ..addListener(() {
            _minuteController!.position.isScrollingNotifier.addListener(() {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (timeState!.widget.isOnValueChangeMode &&
                    !_minuteController!.position.isScrollingNotifier.value) {
                  timeState!.onOk();
                }
              });
            });
          });
    if (hours.isEmpty || minutes.isEmpty) {
      setState(() {
        hours = _hours;
        minutes = _minutes;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (timeState == null) {
      timeState = TimeModelBinding.of(context);
      init();
    }
    super.didChangeDependencies();
  }

  int getModifiedLabel(int value) {
    if (value == 0) {
      return 12;
    }
    if (value > 12) {
      return value - 12;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return FilterWrapper(
      child: WrapperDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DayNightBanner(),
            WrapperContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AmPm(),
                  Expanded(
                    child: Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DisplayWheel(
                          controller: _hourController!,
                          items: hours,
                          isSelected: timeState!.hourIsSelected,
                          onChange: (int value) {
                            timeState!.onHourChange(hours[value]! + 0.0);
                          },
                          disabled: timeState!.widget.disableHour!,
                          getModifiedLabel: getModifiedLabel,
                        ),
                        Text(timeState!.widget.hourLabel!),
                        DisplayWheel(
                          controller: _minuteController!,
                          items: minutes,
                          isSelected: !timeState!.hourIsSelected,
                          onChange: (int value) {
                            timeState!.onMinuteChange(minutes[value]! + 0.0);
                          },
                          disabled: timeState!.widget.disableMinute!,
                        ),
                        Text(timeState!.widget.minuteLabel!),
                      ],
                    ),
                  ),
                  ActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
