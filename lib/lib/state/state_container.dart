import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';

class TimeModelBinding extends StatefulWidget {
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

  /// Ok button's text style [TextStyle]
  TextStyle okStyle;

  /// Cancel button's text style [TextStyle]
  TextStyle cancelStyle;

  final Widget child;
  TimeModelBinding({
    Key? key,
    required this.initialTime,
    required this.child,
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

  static TimeModelBindingState of(BuildContext context) {
    final _ModelBindingScope scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    return scope.modelBindingState;
  }
}

class _ModelBindingScope extends InheritedWidget {
  final TimeModelBindingState modelBindingState;

  const _ModelBindingScope({
    Key? key,
    required this.modelBindingState,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class TimeModelBindingState extends State<TimeModelBinding> {
  late Time time = widget.initialTime;
  bool hourIsSelected = true;
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

  bool didPeriodChange() {
    return lastPeriod != time.period;
  }

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

  void onHourChange(double value) {
    setState(() {
      time = time.replacing(hour: value.round());
    });
  }

  void onMinuteChange(double value) {
    setState(() {
      time = time.replacing(minute: value.ceil());
    });
  }

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
