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
/// **isInlinePicker** - Whether to render an inline widget. Defaults to `false`.
///
/// **onChangeDateTime** - Return the new time the user picked as [DateTime].
///
/// **onCancel** - Custom callback for the Cancel button. Note: if provided, it will override the default behavior of the Cancel button.
///
/// **is24HrFormat** - Show the time in TimePicker in 24 hour format. Defaults to `false`.
///
/// **accentColor** - Accent color of the TimePicker. Defaults to `Theme.of(context).accentColor`.
///
/// **unselectedColor** - Color applied unselected options (am/pm, hour/minute). Defaults to `Colors.grey`.
///
/// **cancelText** - Text displayed for the Cancel button. Defaults to `Cancel`.
///
/// **okText** - Text displayed for the Ok button. Defaults to `Ok`.
///
/// **amLabel** - Text displayed for the 'am' text. Defaults to `am`.
///
/// **pmLabel** - Text displayed for the 'pm' text. Defaults to `pm`.
///
/// **sunAsset** - Image asset used for the Sun. Default asset provided.
///
/// **moonAsset** - Image asset used for the Moon. Default asset provided.
///
/// **blurredBackground** - Whether to blur the background of the [Modal]. Defaults to `false`.
///
/// **backgroundColor** - Set to the background of the [Modal]. Defaults to `Colors.white`.
///
/// **barrierColor** - Color of the background of the [Modal]. Defaults to `Colors.black45`.
///
/// **borderRadius** - Border radius of the [Container] in `double`. Defaults to `10.0`.
///
/// **elevation** - Elevation of the [Modal] in double. Defaults to `12.0`.
///
/// **dialogInsetPadding** - Inset padding of the [Modal] in EdgeInsets. Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
///
/// **contentPadding** - Inset padding of the time content (exclude the night/sun animation) in EdgeInsets. Defaults to `EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)`.
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
/// **secondLabel** - The label to be displayed for `second` picker. Only for _iosStylePicker_. Defaults to `'seconds'`.
///
/// **minuteInterval** - Steps interval while changing `minute`. Accepts `TimePickerInterval` enum. Defaults to `TimePickerInterval.ONE`.
///
/// **secondInterval** - Steps interval while changing `second`. Accepts `TimePickerInterval` enum. Defaults to `TimePickerInterval.ONE`.
///
/// **disableMinute** - Disables the minute picker. Defaults to `false`.
///
/// **disableHour** - Disables the hour picker. Defaults to `false`.
///
/// **maxHour** - Selectable maximum hour. Defaults to `12` | `23`.
///
/// **maxMinute** - Selectable maximum minute. Defaults to `59`.
///
/// **maxSecond** - Selectable maximum second. Defaults to `59`.
///
/// **minHour** - Selectable minimum hour. Defaults to `0` | `1`.
///
/// **minMinute** - Selectable minimum minute. Defaults to `0`.
///
/// **minSecond** - Selectable minimum second. Defaults to `0`.
///
/// **focusMinutePicker** - Whether or not the minute picker is auto focus/selected. Defaults to `false`.
///
/// **themeData** - ThemeData to use for the widget.
///
/// **okStyle** - Ok button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
///
/// **cancelStyle** - Cancel button's text style. Defaults to `const TextStyle(fontWeight: FontWeight.bold)`.
///
/// **hmsStyle** - Set text style of 'hours', 'minutes', and 'seconds'. Defaults to `null`.
///
/// **hideButtons** - Whether to hide the buttons (ok and cancel). Defaults to `false`.
///
/// **disableAutoFocusToNextInput** - Whether to disable the auto focus to the next input after current input is selected. Defaults to `false`.
///
/// **width** - Fixed width of the Picker container. Defaults to `300` but `350` for `iosStyle`.
///
/// **height** - Fixed height of the Picker container. Defaults to `245`.
///
/// **wheelHeight** - Fixed height of the iOS style scrolling wheel. Defaults to `100`.
///
/// **showSecondSelector** - Whether to use the second selector as well. Defaults to `false`.
///
/// **settings** - Data that might be useful in constructing a [Route].
///
dynamic showPicker({
  Key? key,
  BuildContext? context,
  required Time value,
  required void Function(Time) onChange,
  bool isInlinePicker = false,
  void Function(DateTime)? onChangeDateTime,
  void Function()? onCancel,
  bool is24HrFormat = false,
  Color? accentColor,
  Color? unselectedColor,
  bool isOnChangeValueMode = false,
  String cancelText = 'Cancel',
  String okText = 'Ok',
  String amLabel = 'am',
  String pmLabel = 'pm',
  Image? sunAsset,
  Image? moonAsset,
  bool blurredBackground = false,
  bool ltrMode = true,
  Color barrierColor = Colors.black45,
  double? borderRadius,
  double? elevation,
  EdgeInsets? dialogInsetPadding =
      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  bool barrierDismissible = true,
  bool iosStylePicker = false,
  bool displayHeader = true,
  String hourLabel = 'hours',
  String minuteLabel = 'minutes',
  String secondLabel = 'seconds',
  TimePickerInterval minuteInterval = TimePickerInterval.ONE,
  TimePickerInterval secondInterval = TimePickerInterval.ONE,
  bool disableMinute = false,
  bool disableHour = false,
  double minMinute = 0,
  double maxMinute = 59,
  double minSecond = 0,
  double maxSecond = 59,
  ThemeData? themeData,
  bool focusMinutePicker = false,
  // Infinity is used so that we can assert whether or not the user actually set a value
  double minHour = double.infinity,
  double maxHour = double.infinity,
  TextStyle okStyle = const TextStyle(fontWeight: FontWeight.bold),
  TextStyle cancelStyle = const TextStyle(fontWeight: FontWeight.bold),
  TextStyle? hmsStyle,
  ButtonStyle? buttonStyle,
  ButtonStyle? cancelButtonStyle,
  double? buttonsSpacing,
  bool hideButtons = false,
  bool disableAutoFocusToNextInput = false,
  double width = 300,
  double? height,
  bool showSecondSelector = false,
  double? wheelHeight,
  double? wheelMagnification,
  bool showCancelButton = true,
  sunrise = const TimeOfDay(hour: 6, minute: 0),
  sunset = const TimeOfDay(hour: 18, minute: 0),
  duskSpanInMinutes = 120,
  RouteSettings? settings,
  Color? backgroundColor,
}) {
  if (minHour == double.infinity) {
    minHour = 0;
  }
  if (maxHour == double.infinity) {
    maxHour = 23;
  }

  if (iosStylePicker) {
    width = 350;
  }

  assert(
    !(disableHour == true && disableMinute == true),
    'Both "disableMinute" and "disableHour" cannot be true.',
  );
  assert(
    !(disableMinute == true && focusMinutePicker == true),
    'Both "disableMinute" and "focusMinutePicker" cannot be true.',
  );
  assert(maxMinute <= 59, '"maxMinute" must be less than or equal to 59');
  assert(minMinute >= 0, '"minMinute" must be greater than or equal to 0');
  assert(
    maxHour <= 23 && minHour >= 0,
    '"minHour" and "maxHour" should be between 0-23',
  );

  final timeValue = Time.fromTimeOfDay(value, value.second);

  TimeModelBinding timeModelBinding(child) => TimeModelBinding(
        key: key,
        initialTime: timeValue,
        isInlineWidget: isInlinePicker,
        onChange: onChange,
        onChangeDateTime: onChangeDateTime,
        onCancel: onCancel,
        is24HrFormat: is24HrFormat,
        displayHeader: displayHeader,
        accentColor: accentColor,
        unselectedColor: unselectedColor,
        cancelText: cancelText,
        okText: okText,
        amLabel: amLabel,
        pmLabel: pmLabel,
        sunAsset: sunAsset,
        moonAsset: moonAsset,
        blurredBackground: blurredBackground,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        elevation: elevation,
        dialogInsetPadding: dialogInsetPadding,
        contentPadding: contentPadding,
        minuteInterval: minuteInterval,
        secondInterval: secondInterval,
        disableMinute: disableMinute,
        disableHour: disableHour,
        maxHour: maxHour,
        maxMinute: maxMinute,
        maxSecond: maxSecond,
        minHour: minHour,
        minMinute: minMinute,
        minSecond: minSecond,
        focusMinutePicker: focusMinutePicker,
        okStyle: okStyle,
        cancelStyle: cancelStyle,
        hmsStyle: hmsStyle,
        buttonStyle: buttonStyle,
        cancelButtonStyle: cancelButtonStyle,
        buttonsSpacing: buttonsSpacing,
        hourLabel: hourLabel,
        minuteLabel: minuteLabel,
        secondLabel: secondLabel,
        ltrMode: ltrMode,
        disableAutoFocusToNextInput: disableAutoFocusToNextInput,
        width: width,
        height: height,
        showSecondSelector: showSecondSelector,
        wheelHeight: wheelHeight,
        wheelMagnification: wheelMagnification,
        isOnValueChangeMode: isOnChangeValueMode,
        hideButtons: hideButtons,
        showCancelButton: showCancelButton,
        child: child,
        sunrise: sunrise,
        sunset: sunset,
        duskSpanInMinutes: duskSpanInMinutes,
      );

  if (isInlinePicker) {
    return timeModelBinding(
      Builder(
        builder: (context) {
          if (iosStylePicker) {
            return Builder(
              builder: (context) {
                return Theme(
                  data: themeData ?? Theme.of(context),
                  child: DayNightTimePickerIos(
                    sunrise: sunrise,
                    sunset: sunset,
                    duskSpanInMinutes: duskSpanInMinutes,
                  ),
                );
              },
            );
          } else {
            return Builder(
              builder: (context) {
                return Theme(
                  data: themeData ?? Theme.of(context),
                  child: DayNightTimePickerAndroid(
                    sunrise: sunrise,
                    sunset: sunset,
                    duskSpanInMinutes: duskSpanInMinutes,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  return PageRouteBuilder(
    pageBuilder: (context, _, __) {
      if (iosStylePicker) {
        return Theme(
          data: themeData ?? Theme.of(context),
          child: DayNightTimePickerIos(
            sunrise: sunrise,
            sunset: sunset,
            duskSpanInMinutes: duskSpanInMinutes,
          ),
        );
      } else {
        return Theme(
          data: themeData ?? Theme.of(context),
          child: DayNightTimePickerAndroid(
            sunrise: sunrise,
            sunset: sunset,
            duskSpanInMinutes: duskSpanInMinutes,
          ),
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
        child: timeModelBinding(child),
      ),
    ),
    barrierDismissible: barrierDismissible,
    opaque: false,
    barrierColor: barrierColor,
    settings: settings,
  );
}

@Deprecated(
  'Please pass boolean prop `isInlinePicker` to `showPicker` to render an inline picker',
)
void createInlinePicker() {}
