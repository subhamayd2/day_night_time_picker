// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/common/action_buttons.dart';
import 'package:day_night_time_picker/lib/common/display_wheel.dart';
import 'package:day_night_time_picker/lib/common/filter_wrapper.dart';
import 'package:day_night_time_picker/lib/common/wrapper_container.dart';
import 'package:day_night_time_picker/lib/common/wrapper_dialog.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';

import 'ampm.dart';
import 'daynight_banner.dart';
import 'utils.dart';

/// Private class. [StatefulWidget] that renders the content of the picker.
// ignore: must_be_immutable
class DayNightTimePickerIos extends StatefulWidget {
  const DayNightTimePickerIos({
    Key? key,
    required this.sunrise,
    required this.sunset,
    required this.duskSpanInMinutes,
  }) : super(key: key);
  final TimeOfDay sunrise;
  final TimeOfDay sunset;
  final int duskSpanInMinutes;

  @override
  _DayNightTimePickerIosState createState() => _DayNightTimePickerIosState();
}

/// Picker state class
class _DayNightTimePickerIosState extends State<DayNightTimePickerIos> {
  /// Instance of the time state
  TimeModelBindingState? timeState;

  /// Controller for `hour` list
  FixedExtentScrollController? _hourController;

  /// Controller for `minute` list
  FixedExtentScrollController? _minuteController;

  /// Controller for `second` list
  FixedExtentScrollController? _secondController;

  /// List of hours to show
  List<int?> hours = [];

  /// List of minutes to show
  List<int?> minutes = [];

  /// List of seconds to show
  List<int?> seconds = [];

  /// Whether to display the time from left to right or right to left.(Standard: left to right)
  TextDirection? ltrMode;

  /// initial setup
  void init() {
    final hourDiv =
        ((timeState!.widget.maxHour! - timeState!.widget.minHour!) + 1).round();
    final _hours = generateHours(
      hourDiv,
      timeState!.widget.minHour,
      timeState!.widget.maxHour,
    );

    double minMinute =
        getMin(timeState!.widget.minMinute, timeState!.widget.minuteInterval);
    double maxMinute =
        getMax(timeState!.widget.maxMinute, timeState!.widget.minuteInterval);

    double minSecond =
        getMin(timeState!.widget.minSecond, timeState!.widget.secondInterval);
    double maxSecond =
        getMax(timeState!.widget.maxSecond, timeState!.widget.secondInterval);

    int minDiff = (maxMinute - minMinute).round();
    int secDiff = (maxSecond - minSecond).round();

    final minuteDiv = getDivisions(minDiff, timeState!.widget.minuteInterval);
    List<int?> _minutes = generateMinutesOrSeconds(
      minuteDiv,
      timeState!.widget.minuteInterval,
      minMinute,
      maxMinute,
    );

    final secondDiv = getDivisions(secDiff, timeState!.widget.secondInterval);
    List<int?> _seconds = generateMinutesOrSeconds(
      secondDiv,
      timeState!.widget.secondInterval,
      minSecond,
      maxSecond,
    );

    final h = timeState!.time.hour;
    final m = timeState!.time.minute;
    final s = timeState!.time.second;

    _hourController =
        FixedExtentScrollController(initialItem: _hours.indexOf(h))
          ..addListener(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                timeState!.onSelectedInputChange(SelectedInput.HOUR);
              }
            });
          })
          ..addListener(() {
            _hourController!.position.isScrollingNotifier.addListener(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_hourController!.position.isScrollingNotifier.value) {
                  if (!timeState!.widget.disableAutoFocusToNextInput) {
                    if (!(timeState!.widget.disableMinute ?? false)) {
                      timeState!.onSelectedInputChange(SelectedInput.MINUTE);
                    } else if (timeState!.widget.showSecondSelector) {
                      timeState!.onSelectedInputChange(SelectedInput.SECOND);
                    }
                  }
                  if (timeState!.widget.isOnValueChangeMode) {
                    timeState!.onOk();
                  }
                }
              });
            });
          });

    _minuteController =
        FixedExtentScrollController(initialItem: _minutes.indexOf(m))
          ..addListener(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                timeState!.onSelectedInputChange(SelectedInput.MINUTE);
                setState(() {
                  hours = _hours;
                  minutes = _minutes;
                  seconds = _seconds;
                });
              }
            });
          })
          ..addListener(() {
            _minuteController!.position.isScrollingNotifier.addListener(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_minuteController!.position.isScrollingNotifier.value) {
                  if (!timeState!.widget.disableAutoFocusToNextInput &&
                      timeState!.widget.showSecondSelector) {
                    timeState!.onSelectedInputChange(SelectedInput.SECOND);
                  }
                  if (timeState!.widget.isOnValueChangeMode) {
                    timeState!.onOk();
                  }
                }
              });
            });
          });

    if (timeState!.widget.showSecondSelector) {
      _secondController =
          FixedExtentScrollController(initialItem: _seconds.indexOf(s))
            ..addListener(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  timeState!.onSelectedInputChange(SelectedInput.SECOND);
                  setState(() {
                    hours = _hours;
                    minutes = _minutes;
                    seconds = _seconds;
                  });
                }
              });
            })
            ..addListener(() {
              _secondController!.position.isScrollingNotifier.addListener(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (timeState!.widget.isOnValueChangeMode &&
                      !_secondController!.position.isScrollingNotifier.value) {
                    timeState!.onOk();
                  }
                });
              });
            });
    }
    if (hours.isEmpty || minutes.isEmpty || seconds.isEmpty) {
      setState(() {
        hours = _hours;
        minutes = _minutes;
        seconds = _seconds;
      });
    }

    ltrMode = timeState!.widget.ltrMode ? TextDirection.ltr : TextDirection.rtl;
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
    if (value == 0 && timeState!.widget.is24HrFormat) {
      return 0;
    } else if (value == 0 && !timeState!.widget.is24HrFormat) {
      return 12;
    }
    if (value > 12 && timeState!.widget.is24HrFormat) {
      return value;
    } else if (value > 12 && !timeState!.widget.is24HrFormat) {
      return value - 12;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double wheelHeight = TimeModelBinding.of(context).widget.wheelHeight;

    return Center(
      child: SingleChildScrollView(
        physics: currentOrientation == Orientation.portrait
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        child: FilterWrapper(
          child: WrapperDialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DayNightBanner(
                  sunrise: widget.sunrise,
                  sunset: widget.sunset,
                  duskSpanInMinutes: widget.duskSpanInMinutes,
                ),
                WrapperContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const AmPm(),
                      const Spacer(),
                      SizedBox(
                        height: wheelHeight,
                        child: Row(
                          textDirection: ltrMode,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DisplayWheel(
                              controller: _hourController!,
                              items: hours,
                              isSelected:
                                  timeState!.selected == SelectedInput.HOUR,
                              onChange: (int value) {
                                timeState!.onHourChange(hours[value]! + 0.0);
                              },
                              disabled: timeState!.widget.disableHour!,
                              getModifiedLabel: getModifiedLabel,
                            ),
                            Text(
                              timeState!.widget.hourLabel!,
                              style: timeState!.widget.hmsStyle,
                            ),
                            DisplayWheel(
                              controller: _minuteController!,
                              items: minutes,
                              isSelected:
                                  timeState!.selected == SelectedInput.MINUTE,
                              onChange: (int value) {
                                timeState!
                                    .onMinuteChange(minutes[value]! + 0.0);
                              },
                              disabled: timeState!.widget.disableMinute!,
                            ),
                            Text(
                              timeState!.widget.minuteLabel!,
                              style: timeState!.widget.hmsStyle,
                            ),
                            ...(timeState!.widget.showSecondSelector
                                ? [
                                    DisplayWheel(
                                      controller: _secondController!,
                                      items: seconds,
                                      isSelected: timeState!.selected ==
                                          SelectedInput.SECOND,
                                      onChange: (int value) {
                                        timeState!.onSecondChange(
                                          seconds[value]! + 0.0,
                                        );
                                      },
                                    ),
                                    Text(
                                      timeState!.widget.secondLabel!,
                                      style: timeState!.widget.hmsStyle,
                                    ),
                                  ]
                                : []),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (!timeState!.widget.hideButtons) const ActionButtons(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
