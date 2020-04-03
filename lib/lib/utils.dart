String padNumber(int num) {
  if (num < 10) {
    return "0$num";
  }
  return "$num";
}

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

double mapRange(
  double value,
  double iMin,
  double iMax, [
  double oMin = 0,
  double oMax = 1,
]) {
  return ((value - iMin) * (oMax - oMin)) / (iMax - iMin) + oMin;
}

const SUN_MOON_WIDTH = 100.0;
