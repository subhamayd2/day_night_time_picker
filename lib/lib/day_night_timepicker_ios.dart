import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/filter_wrapper.dart';
import 'package:flutter/material.dart';

import 'ampm.dart';
import 'daynight_banner.dart';
import 'utils.dart';

/// Default Border radius value in [double]
const _BORDER_RADIUS = BORDER_RADIUS;

/// Default Elevation value in [double]
const _ELEVATION = ELEVATION;

/// Private class. [StatefulWidget] that renders the content of the picker.
// ignore: must_be_immutable
class DayNightTimePickerIos extends StatefulWidget {
  /// **`Required`** Display value. It takes in [TimeOfDay].
  final TimeOfDay value;

  /// **`Required`** Return the new time the user picked as [TimeOfDay].
  final void Function(TimeOfDay) onChange;

  /// _`Optional`_ Return the new time the user picked as [DateTime].
  final void Function(DateTime)? onChangeDateTime;

  /// Show the time in TimePicker in 24 hour format.
  final bool is24HrFormat;

  /// Display the sun moon animation
  final bool? displayHeader;

  /// Accent color of the TimePicker.
  final Color? accentColor;

  /// Accent color of unselected text.
  final Color? unselectedColor;

  /// Text displayed for the Cancel button.
  String cancelText;

  /// Text displayed for the Ok button.
  String okText;

  /// Image asset used for the Sun.
  final Image? sunAsset;

  /// Image asset used for the Moon.
  final Image? moonAsset;

  /// Whether to blur the background of the [Modal].
  final bool blurredBackground;

  /// Border radius of the [Container] in [double].
  final double? borderRadius;

  /// Elevation of the [Modal] in [double].
  final double? elevation;

  /// Inset padding of the [Modal] in [EdgeInsets].
  final EdgeInsets? dialogInsetPadding;

  /// Label for the `hour` text.
  final String? hourLabel;

  /// Label for the `minute` text.
  final String? minuteLabel;

  /// Steps interval while changing [minute].
  final MinuteInterval? minuteInterval;

  /// Disable minute picker
  final bool? disableMinute;

  /// Disable hour picker
  final bool? disableHour;

  /// Selectable maximum hour
  final double? maxHour;

  /// Selectable maximum minute
  final double? maxMinute;

  /// Selectable minimum hour
  final double? minHour;

  /// Selectable minimum minute
  final double? minMinute;

  /// Whether the widget is displayed as a popup or inline
  final bool isInlineWidget;

  /// Weather to hide okText, cancelText and return value on every onValueChange.
  final bool isOnValueChangeMode;

  /// Whether or not the minute picker is auto focus/selected.
  final bool focusMinutePicker;

  /// Initialize the picker [Widget]
  DayNightTimePickerIos({
    required this.value,
    required this.onChange,
    this.onChangeDateTime,
    this.is24HrFormat = false,
    this.displayHeader,
    this.accentColor,
    this.unselectedColor,
    this.cancelText = "cancel",
    this.okText = "ok",
    this.isOnValueChangeMode = false,
    this.sunAsset,
    this.moonAsset,
    this.blurredBackground = false,
    this.borderRadius,
    this.elevation,
    this.dialogInsetPadding,
    this.hourLabel,
    this.minuteLabel,
    this.minuteInterval,
    this.disableMinute,
    this.disableHour,
    this.maxHour,
    this.maxMinute,
    this.minHour,
    this.minMinute,
    this.isInlineWidget = false,
    this.focusMinutePicker = false,
  }) {
    if (isInlineWidget) {
      this.cancelText = "reset";
      this.okText = "apply";
    }
  }

  @override
  _DayNightTimePickerIosState createState() => _DayNightTimePickerIosState();
}

/// Picker state class
class _DayNightTimePickerIosState extends State<DayNightTimePickerIos> {
  /// Current selected hour
  int? hour;

  /// Current selected minute
  late int minute;

  /// Current selected AM/PM
  String? a;

  /// Currently changing the hour section
  bool hourIsSelected = true;

  /// Default Ok/Cancel [TextStyle]
  final okCancelStyle = const TextStyle(fontWeight: FontWeight.bold);

  /// Controller for `hour` list
  FixedExtentScrollController? _hourController;

  /// Controller for `minute` list
  FixedExtentScrollController? _minuteController;

  /// List of hours to show
  List<int?> hours = [];

  /// List of minutes to show
  List<int?> minutes = [];

  @override
  void initState() {
    bool _hourIsSelected = true;

    if (widget.focusMinutePicker || widget.disableHour!) {
      _hourIsSelected = false;
    }

    setState(() {
      hourIsSelected = _hourIsSelected;
    });
    final hourDiv = ((widget.maxHour! - widget.minHour!) + 1).round();
    final _hours = generateHours(
      hourDiv,
      widget.minHour,
      widget.maxHour,
    );

    double minMinute = getMinMinute(widget.minMinute, widget.minuteInterval);
    double maxMinute = getMaxMinute(widget.maxMinute, widget.minuteInterval);

    int minDiff = (maxMinute - minMinute).round();
    final minuteDiv = getMinuteDivisions(minDiff, widget.minuteInterval);
    List<int?> _minutes = generateMinutes(
      minuteDiv,
      widget.minuteInterval,
      minMinute,
      maxMinute,
    );
    final initialVal = separateHoursAndMinutes(init: true);

    _hourController = FixedExtentScrollController(
        initialItem: _hours.indexOf(initialVal['h']))
      ..addListener(() {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            hourIsSelected = true;
          });
        });
      })
      ..addListener(() {
        _hourController!.position.isScrollingNotifier.addListener(() {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (widget.isOnValueChangeMode &&
                !_hourController!.position.isScrollingNotifier.value) {
              onOk();
            }
          });
        });
      });
    _minuteController = FixedExtentScrollController(
        initialItem: _minutes.indexOf(initialVal['m']))
      ..addListener(() {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            hourIsSelected = false;
            hours = _hours;
            minutes = _minutes;
          });
        });
      })
      ..addListener(() {
        _minuteController!.position.isScrollingNotifier.addListener(() {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (widget.isOnValueChangeMode &&
                !_minuteController!.position.isScrollingNotifier.value) {
              onOk();
            }
          });
        });
      });
    setState(() {
      hours = _hours;
      minutes = _minutes;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(DayNightTimePickerIos oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.is24HrFormat != widget.is24HrFormat ||
        oldWidget.value != widget.value) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        separateHoursAndMinutes();
      });
    }
  }

  /// Separate out the hour and minute from a string
  Map<String, int> separateHoursAndMinutes({bool init = false}) {
    int _h = widget.value.hour;
    int _m = widget.value.minute;
    String _a = "am";

    if (!widget.is24HrFormat) {
      if (_h == 0) {
        _h = 12;
      } else if (_h == 12) {
        _a = "pm";
      } else if (_h > 12) {
        _a = "pm";
        _h -= 12;
      }
    }

    setState(() {
      hour = _h;
      minute = _m;
      a = _a;
    });
    if (!init) {
      _hourController!.jumpToItem(hours.indexOf(_h));
      _minuteController!.jumpToItem(minutes.indexOf(_m));
    }
    return {
      "h": _h,
      "m": _m,
    };
  }

  /// Change handler for hour picker
  onChangeHour(double value) {
    setState(() {
      hour = value.round();
    });
  }

  /// Change handler for minute picker
  onChangeMinute(double value) {
    setState(() {
      minute = value.round();
    });
  }

  /// Hnadle should change hour or minute
  changeCurrentSelector(bool isHour) {
    setState(() {
      hourIsSelected = isHour;
    });
  }

  /// [onChange] handler. Return [TimeOfDay]
  onOk() {
    var time = TimeOfDay(
      hour: getHours(hour, a, widget.is24HrFormat)!,
      minute: minute,
    );
    widget.onChange(time);
    if (widget.onChangeDateTime != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      widget.onChangeDateTime!(dateTime);
    }
    onCancel(result: widget.value);
  }

  /// Handler to close the picker
  onCancel({var result}) {
    if (!widget.isInlineWidget) {
      Navigator.of(context).pop(result);
    } else {
      separateHoursAndMinutes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _commonTimeStyles = Theme.of(context).textTheme.headline2!.copyWith(
          fontSize: 30,
        );
    double hourMinValue = widget.is24HrFormat ? 0 : 1;
    double hourMaxValue = widget.is24HrFormat ? 23 : 12;

    final height = widget.is24HrFormat ? 200.0 : 240.0;

    final color = widget.accentColor ?? Theme.of(context).accentColor;
    final unselectedColor = widget.unselectedColor ?? Colors.grey;

    final double blurAmount = widget.blurredBackground ? 5 : 0;

    final borderRadius = widget.borderRadius ?? _BORDER_RADIUS;
    final elevation = widget.elevation ?? _ELEVATION;

    return FilterWrapper(
      blurAmount: blurAmount,
      child: Dialog(
        insetPadding: widget.dialogInsetPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              widget.displayHeader!
                  ? DayNightBanner(
                      hour: getHours(hour, a, widget.is24HrFormat),
                      displace:
                          mapRange(hour! * 1.0, hourMinValue, hourMaxValue),
                      sunAsset: widget.sunAsset,
                      moonAsset: widget.moonAsset,
                    )
                  : Container(height: 25, color: Theme.of(context).cardColor),
              Container(
                height: height,
                color: Theme.of(context).cardColor,
                padding:
                    const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (!widget.is24HrFormat)
                      AmPm(
                        accentColor: color,
                        unselectedColor: unselectedColor,
                        selected: a,
                        onChange: (e) {
                          setState(() {
                            a = e;
                          });
                        },
                      ),
                    Expanded(
                      child: Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 64,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: ListWheelScrollView.useDelegate(
                                controller: _hourController,
                                itemExtent: 36,
                                physics: widget.disableHour!
                                    ? const NeverScrollableScrollPhysics()
                                    : const FixedExtentScrollPhysics(),
                                overAndUnderCenterOpacity:
                                    widget.disableHour! ? 0 : 0.25,
                                perspective: 0.01,
                                onSelectedItemChanged: (value) {
                                  onChangeHour(hours[value]! + 0.0);
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: hours.length,
                                  builder: (context, index) {
                                    final hourVal = padNumber(hours[index]!);
                                    return Center(
                                      child: Text(
                                        hourVal,
                                        style: _commonTimeStyles.copyWith(
                                          color: hourIsSelected
                                              ? color
                                              : unselectedColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(widget.hourLabel!),
                          SizedBox(
                            width: 64,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: ListWheelScrollView.useDelegate(
                                controller: _minuteController,
                                itemExtent: 36,
                                physics: widget.disableMinute!
                                    ? const NeverScrollableScrollPhysics()
                                    : const FixedExtentScrollPhysics(),
                                overAndUnderCenterOpacity:
                                    widget.disableMinute! ? 0 : 0.25,
                                perspective: 0.01,
                                onSelectedItemChanged: (value) {
                                  onChangeMinute(minutes[value]! + 0.0);
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: minutes.length,
                                  builder: (context, index) {
                                    final minuteVal = minutes[index]!;
                                    return Center(
                                      child: Text(
                                        "${padNumber(minuteVal)}",
                                        style: _commonTimeStyles.copyWith(
                                          color: !hourIsSelected
                                              ? color
                                              : unselectedColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(widget.minuteLabel!),
                        ],
                      ),
                    ),
                    !widget.isOnValueChangeMode
                        ? Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(color: color),
                                  ),
                                  onPressed: onCancel,
                                  child: Text(
                                    widget.cancelText.toUpperCase(),
                                    style: okCancelStyle,
                                  ),
                                ),
                                TextButton(
                                  onPressed: onOk,
                                  child: Text(
                                    widget.okText.toUpperCase(),
                                    style: okCancelStyle,
                                  ),
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(color: color),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 8,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
