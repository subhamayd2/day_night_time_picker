// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

/// Model wrapper class [Time] for [TimeOfDay]
class Time extends TimeOfDay {
  int second = 0;

  /// Constructor for the class
  Time({required int hour, required int minute, int? second})
      : super(hour: hour, minute: minute) {
    this.second = second ?? 0;
  }

  /// Get [Time] instance from [TimeOfDay]
  factory Time.fromTimeOfDay(TimeOfDay time, int? secondVal) {
    return Time(hour: time.hour, minute: time.minute, second: secondVal);
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
  Time replacing({int? hour, int? minute, int? second}) {
    return Time.fromTimeOfDay(
      super.replacing(hour: hour, minute: minute),
      second ?? this.second,
    );
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
