import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/day_night_timepicker_android.dart';
import 'package:day_night_time_picker/lib/day_night_timepicker_ios.dart';
import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
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
/// **dialogInsetPadding** - Inset padding of the [Modal] in EdgeInsets. Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
///
/// **barrierDismissible** - Whether clicking outside should dismiss the [Modal]. Defaults to `true`.
///
/// **iosStylePicker** - Whether to display a IOS style picker (Not exactly the same). Defaults to `false`.
///
/// **displayHeader** - Whether to display the sun moon animation. Defaults to `true`.
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
///
/// **focusMinutePicker** - Whether or not the minute picker is auto focus/selected. Defaults to `false`.
///
/// **themeData** - ThemeData to use for the widget.
///
/// **okStyle** - Ok button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
///
/// **cancelStyle** - Cancel button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
PageRouteBuilder showPicker({
  BuildContext? context,
  required TimeOfDay value,
  required void Function(TimeOfDay) onChange,
  void Function(DateTime)? onChangeDateTime,
  bool is24HrFormat = false,
  Color? accentColor,
  Color? unselectedColor,
  String cancelText = "Cancel",
  String okText = "Ok",
  Image? sunAsset,
  Image? moonAsset,
  bool blurredBackground = false,
  bool ltrMode = true,
  Color barrierColor = Colors.black45,
  double? borderRadius,
  double? elevation,
  EdgeInsets? dialogInsetPadding =
      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  bool barrierDismissible = true,
  bool iosStylePicker = false,
  bool displayHeader = true,
  String hourLabel = 'hours',
  String minuteLabel = 'minutes',
  MinuteInterval minuteInterval = MinuteInterval.ONE,
  bool disableMinute = false,
  bool disableHour = false,
  double minMinute = 0,
  double maxMinute = 59,
  ThemeData? themeData,
  bool focusMinutePicker = false,
  // Infinity is used so that we can assert whether or not the user actually set a value
  double minHour = double.infinity,
  double maxHour = double.infinity,
  TextStyle okStyle = const TextStyle(fontWeight: FontWeight.bold),
  TextStyle cancelStyle = const TextStyle(fontWeight: FontWeight.bold),
}) {
  if (minHour == double.infinity) {
    minHour = 0;
  }
  if (maxHour == double.infinity) {
    maxHour = 23;
  }

  assert(!(disableHour == true && disableMinute == true),
      "Both \"disableMinute\" and \"disableHour\" cannot be true.");
  assert(!(disableMinute == true && focusMinutePicker == true),
      "Both \"disableMinute\" and \"focusMinutePicker\" cannot be true.");
  assert(maxMinute <= 59, "\"maxMinute\" must be less than or equal to 59");
  assert(minMinute >= 0, "\"minMinute\" must be greater than or equal to 0");
  assert(maxHour <= 23 && minHour >= 0,
      "\"minHour\" and \"maxHour\" should be between 0-23");

  final timeValue = Time.fromTimeOfDay(value);

  return PageRouteBuilder(
    pageBuilder: (context, _, __) {
      if (iosStylePicker) {
        return Theme(
          data: themeData != null ? themeData : Theme.of(context),
          child: DayNightTimePickerIos(),
        );
      } else {
        return Theme(
          data: themeData != null ? themeData : Theme.of(context),
          child: DayNightTimePickerAndroid(),
        );
      }
    },
    transitionDuration: const Duration(milliseconds: 200),
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
        child: TimeModelBinding(
          initialTime: timeValue,
          child: child,
          isInlineWidget: false,
          onChange: onChange,
          onChangeDateTime: onChangeDateTime,
          is24HrFormat: is24HrFormat,
          displayHeader: displayHeader,
          accentColor: accentColor,
          unselectedColor: unselectedColor,
          cancelText: cancelText,
          okText: okText,
          sunAsset: sunAsset,
          moonAsset: moonAsset,
          blurredBackground: blurredBackground,
          borderRadius: borderRadius,
          elevation: elevation,
          dialogInsetPadding: dialogInsetPadding,
          minuteInterval: minuteInterval,
          disableMinute: disableMinute,
          disableHour: disableHour,
          maxHour: maxHour,
          maxMinute: maxMinute,
          minHour: minHour,
          minMinute: minMinute,
          focusMinutePicker: focusMinutePicker,
          okStyle: okStyle,
          cancelStyle: cancelStyle,
          hourLabel: hourLabel,
          minuteLabel: minuteLabel,
          ltrMode: ltrMode,
        ),
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
/// **dialogInsetPadding** - Inset padding of the [Modal] in EdgeInsets. Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
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
/// **displayHeader** - Whether to display the sun moon animation. Defaults to `true`.
///
/// **isOnValueChangeMode** - Weather to hide okText, cancelText and return value on every onValueChange. Defaults to `false`.
///
/// **focusMinutePicker** - Whether or not the minute picker is auto focus/selected. Defaults to `false`.
///
/// **themeData** - ThemeData to use for the widget.
///
/// **okStyle** - Ok button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
///
/// **cancelStyle** - Cancel button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
Widget createInlinePicker({
  BuildContext? context,
  required TimeOfDay value,
  required void Function(TimeOfDay) onChange,
  void Function(DateTime)? onChangeDateTime,
  bool is24HrFormat = false,
  Color? accentColor,
  Color? unselectedColor,
  String cancelText = "Cancel",
  String okText = "Ok",
  bool isOnChangeValueMode = false,
  bool ltrMode = true,
  Image? sunAsset,
  Image? moonAsset,
  bool blurredBackground = false,
  Color barrierColor = Colors.black45,
  double? borderRadius,
  double? elevation,
  EdgeInsets? dialogInsetPadding =
      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  bool barrierDismissible = true,
  bool iosStylePicker = false,
  String hourLabel = 'hours',
  String minuteLabel = 'minutes',
  MinuteInterval minuteInterval = MinuteInterval.ONE,
  bool disableMinute = false,
  bool disableHour = false,
  double minMinute = 0,
  double maxMinute = 59,
  bool displayHeader = true,
  ThemeData? themeData,
  bool focusMinutePicker = false,
  // Infinity is used so that we can assert whether or not the user actually set a value
  double minHour = double.infinity,
  double maxHour = double.infinity,
  TextStyle okStyle: const TextStyle(fontWeight: FontWeight.bold),
  TextStyle cancelStyle: const TextStyle(fontWeight: FontWeight.bold),
}) {
  if (minHour == double.infinity) {
    minHour = 0;
  }
  if (maxHour == double.infinity) {
    maxHour = 23;
  }

  assert(!(disableHour == true && disableMinute == true),
      "Both \"disableMinute\" and \"disableHour\" cannot be true.");
  assert(!(disableMinute == true && focusMinutePicker == true),
      "Both \"disableMinute\" and \"focusMinutePicker\" cannot be true.");
  assert(maxMinute <= 59, "\"maxMinute\" must be less than or equal to 59");
  assert(minMinute >= 0, "\"minMinute\" must be greater than or equal to 0");
  assert(maxHour <= 23 && minHour >= 0,
      "\"minHour\" and \"maxHour\" should be between 0-23");

  final timeValue = Time.fromTimeOfDay(value);

  return TimeModelBinding(
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
    dialogInsetPadding: dialogInsetPadding,
    minuteInterval: minuteInterval,
    disableMinute: disableMinute,
    disableHour: disableHour,
    maxHour: maxHour,
    maxMinute: maxMinute,
    minHour: minHour,
    minMinute: minMinute,
    isInlineWidget: true,
    displayHeader: displayHeader,
    isOnValueChangeMode: isOnChangeValueMode,
    focusMinutePicker: focusMinutePicker,
    okStyle: okStyle,
    cancelStyle: cancelStyle,
    hourLabel: hourLabel,
    minuteLabel: minuteLabel,
    ltrMode: ltrMode,
    initialTime: timeValue,
    child: Builder(
      builder: (context) {
        if (iosStylePicker) {
          return Builder(
            builder: (context) {
              return Theme(
                data: themeData != null ? themeData : Theme.of(context),
                child: DayNightTimePickerIos(),
              );
            },
          );
        } else {
          return Builder(
            builder: (context) {
              return Theme(
                data: themeData != null ? themeData : Theme.of(context),
                child: DayNightTimePickerAndroid(),
              );
            },
          );
        }
      },
    ),
  );
}
