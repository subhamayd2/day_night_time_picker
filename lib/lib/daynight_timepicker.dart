import 'dart:ui';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/day_night_timepicker_android.dart';
import 'package:day_night_time_picker/lib/day_night_timepicker_ios.dart';
import 'package:flutter/material.dart';

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
///
/// **disableMinute** - Disables the minute picker. Defaults to `false`.
///
/// **disableHour** - Disables the hour picker. Defaults to `false`.
///
/// **maxHour** - Selectable maximum hour. Defaults to `12` | `23`.
///
/// **maxMinute** - Selectable maximum minute. Defaults to `59`.
///
/// **minHour** - Selectable minimum hour. Defaults to `0` | `1`.
///
/// **minMinute** - Selectable minimum minute. Defaults to `0`.
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
  bool disableMinute = false,
  bool disableHour = false,
  double minMinute = 0,
  double maxMinute = 59,
  // Infinity is used so that we can assert whether or not the user actually set a value
  double minHour = double.infinity,
  double maxHour = double.infinity,
}) {
  if (minHour == double.infinity) {
    minHour = is24HrFormat ? 0 : 1;
  }
  if (maxHour == double.infinity) {
    maxHour = is24HrFormat ? 23 : 12;
  }

  assert(!(disableHour == true && disableMinute == true),
      "Both \"disableMinute\" and \"disableHour\" cannot be true.");
  assert(maxMinute <= 59, "\"maxMinute\" must be less than or equal to 59");
  assert(minMinute >= 0, "\"minMinute\" must be greater than or equal to 0");
  if (is24HrFormat) {
    assert(maxHour <= 23 && minHour >= 0,
        "\"minHour\" and \"maxHour\" should be between 0-23 for 24-hour format");
  } else {
    assert(maxHour <= 12 && minHour >= 1,
        "\"minHour\" and \"maxHour\" should be between 1-12 for 12-hour format");
  }

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
          disableMinute: disableMinute,
          disableHour: disableHour,
          maxHour: maxHour,
          maxMinute: maxMinute,
          minHour: minHour,
          minMinute: minMinute,
        );
      } else {
        return DayNightTimePickerAndroid(
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
          disableMinute: disableMinute,
          disableHour: disableHour,
          maxHour: maxHour,
          maxMinute: maxMinute,
          minHour: minHour,
          minMinute: minMinute,
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

/// This method is used to render an inline version of the picker.
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
///
/// **disableMinute** - Disables/hides the minute picker. Defaults to `false`.
///
/// **disableHour** - Disables/hides the hour picker. Defaults to `false`.
///
/// **maxHour** - Selectable maximum hour. Defaults to `12` | `23`.
///
/// **maxMinute** - Selectable maximum minute. Defaults to `59`.
///
/// **minHour** - Selectable minimum hour. Defaults to `0` | `1`.
///
/// **minMinute** - Selectable minimum minute. Defaults to `0`.
///
Widget createInlinePicker({
  BuildContext context,
  @required TimeOfDay value,
  @required void Function(TimeOfDay) onChange,
  void Function(DateTime) onChangeDateTime,
  bool is24HrFormat = false,
  Color accentColor,
  Color unselectedColor,
  String cancelText = "cancel",
  String okText = "ok",
  bool isOnChangeValueMode = false,
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
  bool disableMinute = false,
  bool disableHour = false,
  double minMinute = 0,
  double maxMinute = 59,
  // Infinity is used so that we can assert whether or not the user actually set a value
  double minHour = double.infinity,
  double maxHour = double.infinity,
}) {
  if (minHour == double.infinity) {
    minHour = is24HrFormat ? 0 : 1;
  }
  if (maxHour == double.infinity) {
    maxHour = is24HrFormat ? 23 : 12;
  }

  assert(!(disableHour == true && disableMinute == true),
      "Both \"disableMinute\" and \"disableHour\" cannot be true.");
  assert(maxMinute <= 59, "\"maxMinute\" must be less than or equal to 59");
  assert(minMinute >= 0, "\"minMinute\" must be greater than or equal to 0");
  if (is24HrFormat) {
    assert(maxHour <= 23 && minHour >= 0,
        "\"minHour\" and \"maxHour\" should be between 0-23 for 24-hour format");
  } else {
    assert(maxHour <= 12 && minHour >= 1,
        "\"minHour\" and \"maxHour\" should be between 1-12 for 12-hour format");
  }

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
      disableMinute: disableMinute,
      disableHour: disableHour,
      maxHour: maxHour,
      maxMinute: maxMinute,
      minHour: minHour,
      minMinute: minMinute,
      isInlineWidget: true,
      isOnValueChangeMode: isOnChangeValueMode,
    );
  } else {
    return DayNightTimePickerAndroid(
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
      disableMinute: disableMinute,
      disableHour: disableHour,
      maxHour: maxHour,
      maxMinute: maxMinute,
      minHour: minHour,
      minMinute: minMinute,
      isInlineWidget: true,
      isOnValueChangeMode: isOnChangeValueMode,

    );
  }
}
