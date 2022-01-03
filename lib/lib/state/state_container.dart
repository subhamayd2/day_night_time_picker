// ignore_for_file: must_be_immutable

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';

/// Stateful [Widget] for [InheritedWidget]
class TimeModelBinding extends StatefulWidget {
  /// The initial time provided by the user
  final Time initialTime;

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

  /// Label for the `hour` text.
  final String? hourLabel;

  /// Label for the `minute` text.
  final String? minuteLabel;

  /// Whether the widget is displayed as a popup or inline
  final bool isInlineWidget;

  /// Weather to hide okText, cancelText and return value on every onValueChange.
  final bool isOnValueChangeMode;

  /// Whether or not the minute picker is auto focus/selected.
  final bool focusMinutePicker;

  /// Whether to display the time from left to right or right to left.(Standard: left to right)
  final bool ltrMode;

  /// Ok button's text style [TextStyle]
  TextStyle okStyle;

  /// Cancel button's text style [TextStyle]
  TextStyle cancelStyle;

  /// The child [Widget] to render
  final Widget child;

  /// Constructor for the [Widget]
  TimeModelBinding({
    Key? key,
    required this.initialTime,
    required this.child,
    required this.onChange,
    this.onChangeDateTime,
    this.is24HrFormat = false,
    this.displayHeader,
    this.accentColor,
    this.ltrMode = true,
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
    this.minuteInterval,
    this.disableMinute,
    this.disableHour,
    this.maxHour,
    this.maxMinute,
    this.minHour,
    this.minMinute,
    this.hourLabel,
    this.minuteLabel,
    this.isInlineWidget = false,
    this.focusMinutePicker = false,
    this.okStyle: const TextStyle(fontWeight: FontWeight.bold),
    this.cancelStyle: const TextStyle(fontWeight: FontWeight.bold),
  }) : super(key: key);

  @override
  TimeModelBindingState createState() => TimeModelBindingState();

  /// Get the [InheritedWidget]'s state in the tree
  static TimeModelBindingState of(BuildContext context) {
    final _ModelBindingScope scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    return scope.modelBindingState;
  }
}

/// The [InheritedWidget] wrapped with [State]
class _ModelBindingScope extends InheritedWidget {
  /// The State
  final TimeModelBindingState modelBindingState;

  /// Constructor for the [InheritedWidget]
  const _ModelBindingScope({
    Key? key,
    required this.modelBindingState,
    required Widget child,
  }) : super(key: key, child: child);

  /// Update notifier for the [InheritedWidget]
  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

/// [InheritedWidget] State class
class TimeModelBindingState extends State<TimeModelBinding> {
  /// initial time
  late Time time = widget.initialTime;

  /// Whether the hour is currently being selected/changed
  bool hourIsSelected = true;

  /// The last [DayPeriod] value
  DayPeriod lastPeriod = DayPeriod.am;

  @override
  void initState() {
    bool _hourIsSelected = true;

    if (widget.focusMinutePicker || widget.disableHour!) {
      _hourIsSelected = false;
    }

    setState(() {
      hourIsSelected = _hourIsSelected;
    });
    super.initState();
  }

  /// Whether the [DayPeriod] changed or not
  bool didPeriodChange() {
    return lastPeriod != time.period;
  }

  /// Change handler for [DayPeriod]
  void onAmPmChange(DayPeriod e) {
    setState(() {
      lastPeriod = time.period;
      time = time.setPeriod(e);
    });
  }

  /// Change handler for picker
  onTimeChange(double value) {
    if (hourIsSelected) {
      onHourChange(value);
    } else {
      onMinuteChange(value);
    }
  }

  /// Change handler for the `hour`
  void onHourChange(double value) {
    setState(() {
      time = time.replacing(hour: value.round());
    });
  }

  /// Change handler for the `minute`
  void onMinuteChange(double value) {
    setState(() {
      time = time.replacing(minute: value.ceil());
    });
  }

  /// Change handler for `hourIsSelected`
  void onHourIsSelectedChange(bool newValue) {
    setState(() {
      hourIsSelected = newValue;
    });
  }

  /// [onChange] handler. Return [TimeOfDay]
  onOk() {
    widget.onChange(time.toTimeOfDay());
    if (widget.onChangeDateTime != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      widget.onChangeDateTime!(dateTime);
    }
    onCancel(result: time.toTimeOfDay());
  }

  /// Handler to close the picker
  onCancel({var result}) {
    if (!widget.isInlineWidget) {
      Navigator.of(context).pop(result);
    }
  }

  /// Check if time is within range.
  /// Used to disable `AM/PM`.
  /// Example: if user provided [minHour] as `9` and [maxHour] as `21`,
  /// then the user should only be able to toggle `AM/PM` for `9am` and `9pm`
  bool checkIfWithinRange(DayPeriod other) {
    final tempTime = Time(time.hour, time.minute).setPeriod(other);
    final expectedHour = tempTime.hour;
    return widget.minHour! <= expectedHour && expectedHour <= widget.maxHour!;
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
