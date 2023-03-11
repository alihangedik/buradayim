class TurkishDateFormat {
  static String _dateFormat = "";

  String get dateFormat => _dateFormat;

  static const List<String> _days = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  static const List<String> _months = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık'
  ];

  static String turkishDate(DateTime datetime) {
    return _dateFormat =
        '${datetime.day} ${_months[datetime.month - 1]} ${_days[datetime.weekday - 1]} ${datetime.year}';
  }

  static String turkishDateNonYear(DateTime datetime) {
    return _dateFormat =
        '${datetime.day} ${_months[datetime.month - 1]} ${_days[datetime.weekday - 1]}';
  }

  static String turkishDatewithTime(DateTime dateTime) {
    var hour = dateTime.hour <= 9 ? '0${dateTime.hour}' : dateTime.hour;
    var minute = dateTime.minute <= 9 ? '0${dateTime.minute}' : dateTime.minute;
    return _dateFormat =
        '${dateTime.day} ${_months[dateTime.month - 1]} ${_days[dateTime.weekday - 1]} ${dateTime.year} $hour:$minute';
  }

  static String turkishOnlyDay(DateTime dateTime) {
    return _dateFormat = '${dateTime.day} ${_months[dateTime.month - 1]} ';
  }

  static String turkishOnlyDaywithTime(DateTime dateTime) {
    var hour = dateTime.hour <= 9 ? '0${dateTime.hour}' : dateTime.hour;
    var minute = dateTime.minute <= 9 ? '0${dateTime.minute}' : dateTime.minute;
    return _dateFormat =
        '${dateTime.day} ${_months[dateTime.month - 1]} $hour:$minute';
  }

  static String turkishOnlyWeekday(DateTime dateTime) {
    return _dateFormat = '${_days[dateTime.weekday - 1]} ';
  }

  static String turkishOnlyDaywithName(DateTime dateTime) {
    return _dateFormat =
        '${dateTime.day} ${_months[dateTime.month - 1]} ${_days[dateTime.weekday - 1]} ';
  }

  static String turkishOnlyDayName(DateTime dateTime) {
    return _dateFormat = ' ${_months[dateTime.month - 1]}';
  }
}
