// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class Time extends TimeOfDay {
  Time(int hour, int minute) : super(hour: hour, minute: minute);

  factory Time.fromTimeOfDay(TimeOfDay time) {
    return Time(time.hour, time.minute);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: this.hour, minute: this.minute);
  }

  Time setPeriod(DayPeriod period) {
    return this.replacing(hour: _changeHourBasedOnAmPm(this.hour, period));
  }

  Time replacing({int? hour, int? minute}) {
    return Time.fromTimeOfDay(super.replacing(hour: hour, minute: minute));
  }

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
