// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

/// Stateful [Widget] for [InheritedWidget]
class TimeModelBinding extends StatefulWidget {
  /// The initial time provided by the user
  final Time initialTime;

  /// **`Required`** Return the new time the user picked as [Time].
  final void Function(Time) onChange;

  /// _`Optional`_ Return the new time the user picked as [DateTime].
  final void Function(DateTime)? onChangeDateTime;

  /// Callback for the Cancel button
  final void Function()? onCancel;

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

  /// Set the background color of the [Modal].
  final Color backgroundColor;

  /// Border radius of the [Container] in [double].
  final double? borderRadius;

  /// Elevation of the [Modal] in [double].
  final double? elevation;

  /// Inset padding of the [Modal] in [EdgeInsets].
  final EdgeInsets? dialogInsetPadding;

  /// Inset padding of the content in [EdgeInsets].
  final EdgeInsets? contentPadding;

  /// Steps interval while changing [minute].
  final TimePickerInterval? minuteInterval;

  /// Steps interval while changing [secoond].
  final TimePickerInterval? secondInterval;

  /// Disable minute picker
  final bool? disableMinute;

  /// Disable hour picker
  final bool? disableHour;

  /// Selectable maximum hour
  final double? maxHour;

  /// Selectable maximum minute
  final double? maxMinute;

  /// Selectable maximum second
  final double? maxSecond;

  /// Selectable minimum hour
  final double? minHour;

  /// Selectable minimum minute
  final double? minMinute;

  /// Selectable minimum second
  final double? minSecond;

  /// Label for the `hour` text.
  final String? hourLabel;

  /// Label for the `minute` text.
  final String? minuteLabel;

  /// Label for the `second` text.
  final String? secondLabel;

  /// Label for the 'am' text.
  final String amLabel;

  /// Label for the 'pm' text.
  final String pmLabel;

  /// Text style for the 'hours', 'minutes', and 'seconds'
  final TextStyle? hmsStyle;

  /// Whether the widget is displayed as a popup or inline
  final bool isInlineWidget;

  /// Whether to hide okText, cancelText and return value on every onValueChange.
  final bool isOnValueChangeMode;

  /// Whether or not the minute picker is auto focus/selected.
  final bool focusMinutePicker;

  /// Whether to display the time from left to right or right to left.(Standard: left to right)
  final bool ltrMode;

  /// Ok button's text style [TextStyle]
  TextStyle okStyle;

  /// Cancel button's text style [TextStyle]
  TextStyle cancelStyle;

  /// [ButtonStyle] is used for the [showPicker] methods
  /// If `cancelButtonStyle` is not provided, it applies to the ok and cancel buttons
  ButtonStyle? buttonStyle;

  /// [ButtonStyle] is used for the [showPicker] methods
  ButtonStyle? cancelButtonStyle;

  /// Spacing between ok and cancel buttons
  double? buttonsSpacing;

  /// The child [Widget] to render
  final Widget child;

  /// The height of the Wheel section
  double wheelHeight;

  /// The magnification of the Wheel section
  double wheelMagnification;

  /// Whether to hide the buttons (ok and cancel). Defaults to `false`.
  bool hideButtons;

  /// Whether to disable the auto focus to minute after hour is selected.
  bool disableAutoFocusToNextInput;

  /// Fixed width of the Picker container.
  double width;

  /// Fixed height of the Picker container.
  double height;

  /// Whether to use the second selector as well.
  bool showSecondSelector;

  /// Whether to have the Cancel Button Widget.
  bool showCancelButton;

  /// Sunrise time.
  TimeOfDay? sunrise;

  /// Sunset time.
  TimeOfDay? sunset;

  /// Dusk span of time in minutes.
  int? duskSpanInMinutes;

  /// Constructor for the [Widget]
  TimeModelBinding({
    Key? key,
    required this.initialTime,
    required this.child,
    required this.onChange,
    this.onChangeDateTime,
    this.onCancel,
    this.is24HrFormat = false,
    this.displayHeader,
    this.accentColor,
    this.ltrMode = true,
    this.unselectedColor,
    this.cancelText = 'cancel',
    this.okText = 'ok',
    this.isOnValueChangeMode = false,
    this.sunAsset,
    this.moonAsset,
    this.blurredBackground = false,
    Color? backgroundColor,
    this.borderRadius,
    this.elevation,
    this.dialogInsetPadding,
    this.contentPadding,
    this.minuteInterval,
    this.secondInterval,
    this.disableMinute,
    this.disableHour,
    this.maxHour,
    this.maxMinute,
    this.maxSecond,
    this.minHour,
    this.minMinute,
    this.minSecond,
    this.hourLabel,
    this.minuteLabel,
    this.secondLabel,
    this.amLabel = 'am',
    this.pmLabel = 'pm',
    this.isInlineWidget = false,
    this.focusMinutePicker = false,
    this.okStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.cancelStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.hmsStyle,
    this.buttonStyle,
    this.cancelButtonStyle,
    this.buttonsSpacing,
    double? wheelHeight,
    double? wheelMagnification,
    this.hideButtons = false,
    this.disableAutoFocusToNextInput = false,
    this.width = 0,
    double? height,
    this.showSecondSelector = false,
    this.showCancelButton = true,
    this.sunrise,
    this.sunset,
    this.duskSpanInMinutes,
  })  : height = height ?? 260,
        wheelHeight = wheelHeight ?? 100,
        wheelMagnification = wheelMagnification ?? 1.0,
        backgroundColor = backgroundColor ?? Colors.white,
        super(key: key);

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
  SelectedInput selected = SelectedInput.HOUR;

  /// The last [DayPeriod] value
  DayPeriod lastPeriod = DayPeriod.am;

  @override
  void initState() {
    SelectedInput _selected = SelectedInput.HOUR;

    if (widget.focusMinutePicker || widget.disableHour!) {
      _selected = SelectedInput.MINUTE;
    }

    setState(() {
      selected = _selected;
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

    // If the mode is `onValueChange` then we need to alert
    // the listeners that the value changed
    if (widget.isOnValueChangeMode) {
      onOk();
    }
  }

  /// Change handler for picker
  onTimeChange(double value) {
    if (selected == SelectedInput.HOUR) {
      onHourChange(value);
    } else if (selected == SelectedInput.MINUTE) {
      onMinuteChange(value);
    } else {
      onSecondChange(value);
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

  /// Change handler for the `second`
  void onSecondChange(double value) {
    setState(() {
      time = time.replacing(second: value.ceil());
    });
  }

  /// Change handler for `hourIsSelected`
  void onSelectedInputChange(SelectedInput newValue) {
    setState(() {
      selected = newValue;
    });
  }

  /// [onChange] handler. Return [TimeOfDay]
  onOk() {
    widget.onChange(time);
    if (widget.onChangeDateTime != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      widget.onChangeDateTime!(dateTime);
    }
    onCancel(result: time);
  }

  /// Handler to close the picker
  onCancel({var result}) {
    if (widget.onCancel != null) {
      widget.onCancel!();
      return;
    }

    if (!widget.isInlineWidget) {
      Navigator.of(context).pop(result);
    }
  }

  /// Check if time is within range.
  /// Used to disable `AM/PM`.
  /// Example: if user provided [minHour] as `9` and [maxHour] as `21`,
  /// then the user should only be able to toggle `AM/PM` for `9am` and `9pm`
  bool checkIfWithinRange(DayPeriod other) {
    final tempTime = Time(
      hour: time.hour,
      minute: time.minute,
      second: time.second,
    ).setPeriod(other);
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
