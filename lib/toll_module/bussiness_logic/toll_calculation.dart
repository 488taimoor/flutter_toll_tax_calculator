class TollCalculator {
  static const double baseRate = 20;
  static const double distanceRate = 0.2;
  static const Map<String, int> entryPoints = {
    'Zero Point': 0,
    'NS Interchange': 5,
    'Ph4 Interchange': 10,
    'Ferozpur Interchange': 17,
    'Lake City Interchange': 24,
    'Raiwand Interchange': 29,
    'Bahria Interchange': 34,
  };

  static Map<String, double> calculateToll(String entryPoint, String exitPoint,
      DateTime entryDateTime, String numberPlate) {
    int entryDistance = entryPoints[entryPoint] ?? 0;
    int exitDistance = entryPoints[exitPoint] ?? 0;
    int distanceTravelled = (exitDistance - entryDistance).abs();
    double toll = baseRate + (distanceTravelled * distanceRate);

    Map<String, double> receiptStats = {'subTotal': toll, 'base': baseRate, 'distance': distanceTravelled.toDouble()};



    if (isWeekend(entryDateTime)) {
      toll *= 1.5; // 1.5x distance rate on weekends
    }

    if (isDiscountDay(entryDateTime, numberPlate)) {
      toll *= 0.9; // 10% discount
    }

    if (isNationalHoliday(entryDateTime)) {
      toll *= 0.5; // 50% discount on national holidays
    }

    receiptStats['discount'] = receiptStats['subTotal']! - toll;
    receiptStats['total'] = toll;
    return receiptStats;
  }

  static bool isWeekend(DateTime dateTime) {
    return dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday;
  }

  static bool isDiscountDay(DateTime dateTime, String numberPlate) {
    if ((dateTime.weekday == DateTime.monday ||
            dateTime.weekday == DateTime.wednesday) &&
        isEvenPlate(numberPlate)) {
      return true;
    } else if ((dateTime.weekday == DateTime.tuesday ||
            dateTime.weekday == DateTime.thursday) &&
        !isEvenPlate(numberPlate)) {
      return true;
    }
    return false;
  }

  static bool isEvenPlate(String numberPlate) {
    int lastDigit = int.parse(numberPlate.substring(numberPlate.length - 1));
    return lastDigit != null && lastDigit % 2 == 0;
  }

  static bool isNationalHoliday(DateTime dateTime) {
    return dateTime.month == DateTime.march && dateTime.day == 23 ||
        dateTime.month == DateTime.august && dateTime.day == 14 ||
        dateTime.month == DateTime.december && dateTime.day == 25;
  }
}
