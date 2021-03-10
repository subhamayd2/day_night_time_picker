import 'package:day_night_time_picker/lib/constants.dart';

/// Padding single digit number to be double digit
String padNumber(int num) {
  if (num < 10) {
    return "0$num";
  }
  return "$num";
}

/// Get the hour either in 12Hr or 24Hr format
int? getHours(int? h, String? a, bool is24Hr) {
  if (is24Hr) {
    return h;
  }
  if (a == 'am') {
    if (h == 12) {
      return 0;
    }
    return h;
  }
  if (h == 12) {
    return 12;
  }
  return h! + 12;
}

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

int getIntFromMinuteIntervalEnum(MinuteInterval? interval) {
  switch (interval) {
    case MinuteInterval.FIVE:
      return 5;
    case MinuteInterval.TEN:
      return 10;
    case MinuteInterval.FIFTEEN:
      return 15;
    default:
      return 1;
  }
}

/// Map MinuteInterval enum to division values
int getMinuteDivisions(int diff, MinuteInterval? interval) {
  switch (interval) {
    case MinuteInterval.FIVE:
      // 12
      return (diff / 5).round();
    case MinuteInterval.TEN:
      // 6
      return (diff / 10).round();
    case MinuteInterval.FIFTEEN:
      // 4
      return (diff / 15).round();
    default:
      return diff;
  }
}

/// Get the minimum minute from interval
double getMinMinute(double? minMinute, MinuteInterval? interval) {
  if (minMinute == 0) {
    return 0;
  }
  int step = getIntFromMinuteIntervalEnum(interval);

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
double getMaxMinute(double? maxMinute, MinuteInterval? interval) {
  if (maxMinute == 59) {
    return 59;
  }
  int step = getIntFromMinuteIntervalEnum(interval);

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
List<int?> generateMinutes(int divisions, MinuteInterval? interval, min, max) {
  final minutes = List<int?>.generate(divisions + 1, (index) {
    final val = min.round() + (getIntFromMinuteIntervalEnum(interval) * index);
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
