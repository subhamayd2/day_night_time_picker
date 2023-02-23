import 'package:day_night_time_picker/lib/constants.dart';

/// Map a given value between a range
double mapRange(
  double value,
  double iMin,
  double iMax, [
  double oMin = 0,
  double oMax = 1,
]) {
  return ((value - iMin) * (oMax - oMin)) / (iMax - iMin) + oMin;
}

int getIntFromTimePickerIntervalEnum(TimePickerInterval? interval) {
  switch (interval) {
    case TimePickerInterval.FIVE:
      return 5;
    case TimePickerInterval.TEN:
      return 10;
    case TimePickerInterval.FIFTEEN:
      return 15;
    case TimePickerInterval.THIRTY:
      return 30;
    default:
      return 1;
  }
}

/// Map MinuteInterval enum to division values
int getDivisions(int diff, TimePickerInterval? interval) {
  switch (interval) {
    case TimePickerInterval.FIVE:
      // 12
      return (diff / 5).round();
    case TimePickerInterval.TEN:
      // 6
      return (diff / 10).round();
    case TimePickerInterval.FIFTEEN:
      // 4
      return (diff / 15).round();
    case TimePickerInterval.THIRTY:
      // 2
      return (diff / 30).round();
    default:
      return diff;
  }
}

/// Get the minimum minute from interval
double getMin(double? minMinute, TimePickerInterval? interval) {
  if (minMinute == 0) {
    return 0;
  }
  int step = getIntFromTimePickerIntervalEnum(interval);

  double min = -1;
  double i = 1;
  while (min < 0) {
    double val = i * step;
    if (val >= minMinute!) {
      min = val;
    }
    i++;
  }
  return min;
}

/// Get the maximum minute from interval
double getMax(double? maxMinute, TimePickerInterval? interval) {
  if (maxMinute == 59) {
    return 59;
  }
  int step = getIntFromTimePickerIntervalEnum(interval);

  double max = 60;
  double i = 1;
  while (max > maxMinute!) {
    double val = 60 - (i * step);
    if (val <= maxMinute) {
      max = val;
    }
    i++;
  }
  return max;
}

/// Generate a List of minutes
List<int?> generateMinutesOrSeconds(
    int divisions, TimePickerInterval? interval, min, max) {
  final minutes = List<int?>.generate(divisions + 1, (index) {
    final val =
        min.round() + (getIntFromTimePickerIntervalEnum(interval) * index);
    if (val >= max) {
      return max.round();
    }
    return val;
  });
  return minutes;
}

/// Generate a List of hours
List<int?> generateHours(int divisions, min, max) {
  final hours = List<int?>.generate(divisions, (index) {
    final val = min.round() + index;
    if (val >= max) {
      return max.round();
    }
    return val;
  });
  return hours;
}
