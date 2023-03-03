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
    return _dateFormat =
        '${dateTime.day} ${_months[dateTime.month - 1]} ${_days[dateTime.weekday - 1]} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  static String turkishOnlyDay(DateTime dateTime) {
    return _dateFormat = '${dateTime.day} ${_months[dateTime.month - 1]} ';
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
