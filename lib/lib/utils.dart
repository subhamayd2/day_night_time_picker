import 'package:day_night_time_picker/lib/constants.dart';

/// Padding single digit number to be double digit
String padNumber(int num) {
  if (num < 10) {
    return "0$num";
  }
  return "$num";
}

/// Get the hour either in 12Hr or 24Hr format
int getHours(int h, String a, bool is24Hr) {
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
  return h + 12;
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

/// Map MinuteInterval enum to division values
int getMinuteDivisions(MinuteInterval interval) {
  switch (interval) {
    case MinuteInterval.FIVE:
      return 12;
    case MinuteInterval.TEN:
      return 6;
    case MinuteInterval.FIFTEEN:
      return 4;
    default:
      return 60;
  }
}
