// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

/// Model wrapper class [Time] for [TimeOfDay]
class Time extends TimeOfDay {
  /// Constructor for the class
  const Time(int hour, int minute) : super(hour: hour, minute: minute);

  /// Get [Time] instance from [TimeOfDay]
  factory Time.fromTimeOfDay(TimeOfDay time) {
    return Time(time.hour, time.minute);
  }

  /// Get [TimeOfDay] instance from [Time]
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Toggle [DayPeriod]
  Time setPeriod(DayPeriod period) {
    return replacing(hour: _changeHourBasedOnAmPm(hour, period));
  }

  /// Overide [TimeOfDay.replacing]
  @override
  Time replacing({int? hour, int? minute}) {
    return Time.fromTimeOfDay(super.replacing(hour: hour, minute: minute));
  }

  /// Helper for toggling period
  int _changeHourBasedOnAmPm(int hour, DayPeriod a) {
    if (a == DayPeriod.pm && hour < 12) {
      return hour + 12;
    }
    if (a == DayPeriod.am && hour >= 12) {
      return hour - 12;
    }
    return hour;
  }
}
