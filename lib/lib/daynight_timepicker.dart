import 'dart:ui';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/day_night_timepicker_ios.dart';
import 'package:flutter/material.dart';
import './ampm.dart';
import './daynight_banner.dart';
import './utils.dart';

/// Default Border radius value in [double]
const _BORDER_RADIUS = BORDER_RADIUS;

/// Default Elevation value in [double]
const _ELEVATION = ELEVATION;

///
/// The function that shows the *DayNightTimePicker*
///
/// This function takes in the following parameters:
///
/// **value** - `Required` Display value. It takes in [TimeOfDay].
///
/// **onChange** - `Required` Return the new time the user picked as [TimeOfDay].
///
/// **onChangeDateTime** - Return the new time the user picked as [DateTime].
///
/// **is24HrFormat** - Show the time in TimePicker in 24 hour format. Defaults to `false`.
///
/// **accentColor** - Accent color of the TimePicker. Defaults to `Theme.of(context).accentColor`.
///
/// **unselectedColor** - Color applied unselected options (am/pm, hour/minute). Defaults to `Colors.grey`.
///
/// **cancelText** - Text displayed for the Cancel button. Defaults to `cancel`.
///
/// **okText** - Text displayed for the Ok button. Defaults to `ok`.
///
/// **sunAsset** - Image asset used for the Sun. Default asset provided.
///
/// **moonAsset** - Image asset used for the Moon. Default asset provided.
///
/// **blurredBackground** - Whether to blur the background of the [Modal]. Defaults to `false`.
///
/// **barrierColor** - Color of the background of the [Modal]. Defaults to `Colors.black45`.
///
/// **borderRadius** - Border radius of the [Container] in `double`. Defaults to `10.0`.
///
/// **elevation** - Elevation of the [Modal] in double. Defaults to `12.0`.
///
/// **barrierDismissible** - Whether clicking outside should dismiss the [Modal]. Defaults to `true`.
///
/// **iosStylePicker** - Whether to display a IOS style picker (Not exactly the same). Defaults to `false`.
///
/// **hourLabel** - The label to be displayed for `hour` picker. Only for _iosStylePicker_. Defaults to `'hours'`.
///
/// **minuteLabel** - The label to be displayed for `minute` picker. Only for _iosStylePicker_. Defaults to `'minutes'`.
///
/// **minuteInterval** - Steps interval while changing `minute`. Accepts `MinuteInterval` enum. Defaults to `MinuteInterval.ONE`.
PageRouteBuilder showPicker({
  BuildContext context,
  @required TimeOfDay value,
  @required void Function(TimeOfDay) onChange,
  void Function(DateTime) onChangeDateTime,
  bool is24HrFormat = false,
  Color accentColor,
  Color unselectedColor,
  String cancelText = "cancel",
  String okText = "ok",
  Image sunAsset,
  Image moonAsset,
  bool blurredBackground = false,
  Color barrierColor = Colors.black45,
  double borderRadius,
  double elevation,
  bool barrierDismissible = true,
  bool iosStylePicker = false,
  String hourLabel = 'hours',
  String minuteLabel = 'minutes',
  MinuteInterval minuteInterval = MinuteInterval.ONE,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) {
      if (iosStylePicker) {
        return DayNightTimePickerIos(
          value: value,
          onChange: onChange,
          onChangeDateTime: onChangeDateTime,
          is24HrFormat: is24HrFormat,
          accentColor: accentColor,
          unselectedColor: unselectedColor,
          cancelText: cancelText,
          okText: okText,
          sunAsset: sunAsset,
          moonAsset: moonAsset,
          blurredBackground: blurredBackground,
          borderRadius: borderRadius,
          elevation: elevation,
          hourLabel: hourLabel,
          minuteLabel: minuteLabel,
          minuteInterval: minuteInterval,
        );
      } else {
        return _DayNightTimePicker(
          value: value,
          onChange: onChange,
          onChangeDateTime: onChangeDateTime,
          is24HrFormat: is24HrFormat,
          accentColor: accentColor,
          unselectedColor: unselectedColor,
          cancelText: cancelText,
          okText: okText,
          sunAsset: sunAsset,
          moonAsset: moonAsset,
          blurredBackground: blurredBackground,
          borderRadius: borderRadius,
          elevation: elevation,
          minuteInterval: minuteInterval,
        );
      }
    },
    transitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, anim, secondAnim, child) => SlideTransition(
      position: anim.drive(
        Tween(
          begin: const Offset(0, 0.15),
          end: const Offset(0, 0),
        ).chain(
          CurveTween(curve: Curves.ease),
        ),
      ),
      child: FadeTransition(
        opacity: anim,
        child: child,
      ),
    ),
    barrierDismissible: barrierDismissible,
    opaque: false,
    barrierColor: barrierColor,
  );
}

/// Private class. [StatefulWidget] that renders the content of the picker.
class _DayNightTimePicker extends StatefulWidget {
  /// **`Required`** Display value. It takes in [TimeOfDay].
  final TimeOfDay value;

  /// **`Required`** Return the new time the user picked as [TimeOfDay].
  final void Function(TimeOfDay) onChange;

  /// _`Optional`_ Return the new time the user picked as [DateTime].
  final void Function(DateTime) onChangeDateTime;

  /// Show the time in TimePicker in 24 hour format.
  final bool is24HrFormat;

  /// Accent color of the TimePicker.
  final Color accentColor;

  /// Accent color of unselected text.
  final Color unselectedColor;

  /// Text displayed for the Cancel button.
  final String cancelText;

  /// Text displayed for the Ok button.
  final String okText;

  /// Image asset used for the Sun.
  final Image sunAsset;

  /// Image asset used for the Moon.
  final Image moonAsset;

  /// Whether to blur the background of the [Modal].
  final bool blurredBackground;

  /// Border radius of the [Container] in [double].
  final double borderRadius;

  /// Elevation of the [Modal] in [double].
  final double elevation;

  /// Steps interval while changing [minute].
  final MinuteInterval minuteInterval;

  /// Initialize the picker [Widget]
  _DayNightTimePicker({
    Key key,
    @required this.value,
    @required this.onChange,
    this.onChangeDateTime,
    this.is24HrFormat = false,
    this.accentColor,
    this.unselectedColor,
    this.cancelText = "cancel",
    this.okText = "ok",
    this.sunAsset,
    this.moonAsset,
    this.blurredBackground = false,
    this.borderRadius,
    this.elevation,
    this.minuteInterval,
  }) : super(key: key);

  @override
  _DayNightTimePickerState createState() => _DayNightTimePickerState();
}

/// Picker state class
class _DayNightTimePickerState extends State<_DayNightTimePicker> {
  /// Current selected hour
  int hour;

  /// Current selected minute
  int minute;

  /// Current selected AM/PM
  String a;

  /// Currently changing the hour section
  bool changingHour = true;

  /// Default Ok/Cancel [TextStyle]
  final okCancelStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    separateHoursAndMinutes();
    super.initState();
  }

  @override
  void didUpdateWidget(_DayNightTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.is24HrFormat != widget.is24HrFormat ||
        oldWidget.value != widget.value) {
      separateHoursAndMinutes();
    }
  }

  /// Separate out the hour and minute from a string
  void separateHoursAndMinutes() {
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
  }

  /// Change handler for picker
  onChangeTime(double value) {
    if (changingHour) {
      setState(() {
        hour = value.round();
      });
    } else {
      setState(() {
        minute = value.ceil();
      });
    }
  }

  /// Hnadle should change hour or minute
  changeCurrentSelector(bool isHour) {
    setState(() {
      changingHour = isHour;
    });
  }

  /// [onChange] handler. Return [TimeOfDay]
  onOk() {
    var time = TimeOfDay(
      hour: getHours(hour, a, widget.is24HrFormat),
      minute: minute,
    );
    widget.onChange(time);
    if (widget.onChangeDateTime != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      widget.onChangeDateTime(dateTime);
    }
    onCancel();
  }

  /// Handler to close the picker
  onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _commonTimeStyles = Theme.of(context).textTheme.headline2.copyWith(
          fontSize: 62,
          fontWeight: FontWeight.bold,
        );

    double min = 0;
    double max = 59;
    int divisions = getMinuteDivisions(widget.minuteInterval);
    double hourMinValue = widget.is24HrFormat ? 0 : 1;
    double hourMaxValue = widget.is24HrFormat ? 23 : 12;
    if (changingHour) {
      min = 1;
      max = 12;
      divisions = 11;
      if (widget.is24HrFormat) {
        min = 0;
        max = 23;
        divisions = 23;
      }
    }

    final height = widget.is24HrFormat ? 200.0 : 240.0;

    final color = widget.accentColor ?? Theme.of(context).accentColor;
    final unselectedColor = widget.unselectedColor ?? Colors.grey;
    final unselectedOpacity = 1.0;

    final double blurAmount = widget.blurredBackground ?? false ? 5 : 0;

    final borderRadius = widget.borderRadius ?? _BORDER_RADIUS;
    final elevation = widget.elevation ?? _ELEVATION;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
      child: Dialog(
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
              DayNightBanner(
                hour: getHours(hour, a, widget.is24HrFormat),
                displace: mapRange(hour * 1.0, hourMinValue, hourMaxValue),
                sunAsset: widget.sunAsset,
                moonAsset: widget.moonAsset,
              ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: InkWell(
                                onTap: () {
                                  changeCurrentSelector(true);
                                },
                                child: Opacity(
                                  opacity: changingHour ? 1 : unselectedOpacity,
                                  child: Text(
                                    "$hour",
                                    style: _commonTimeStyles.copyWith(
                                        color: changingHour
                                            ? color
                                            : unselectedColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(":", style: _commonTimeStyles),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                changeCurrentSelector(false);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Opacity(
                                  opacity:
                                      !changingHour ? 1 : unselectedOpacity,
                                  child: Text(
                                    "${padNumber(minute)}",
                                    style: _commonTimeStyles.copyWith(
                                        color: !changingHour
                                            ? color
                                            : unselectedColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: changingHour
                          ? hour.roundToDouble()
                          : minute.roundToDouble(),
                      onChanged: onChangeTime,
                      min: min,
                      max: max,
                      divisions: divisions,
                      activeColor: color,
                      inactiveColor: color.withAlpha(55),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: onCancel,
                            child: Text(
                              widget.cancelText.toUpperCase(),
                              style: okCancelStyle,
                            ),
                            textColor: color,
                          ),
                          FlatButton(
                            onPressed: onOk,
                            child: Text(
                              widget.okText.toUpperCase(),
                              style: okCancelStyle,
                            ),
                            textColor: color,
                          ),
                        ],
                      ),
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
