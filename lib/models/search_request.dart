class SearchRequest {
  String? city;
  String? country;
  DateTime? checkIn;
  DateTime? checkOut;
  int adults;
  int children;

  SearchRequest({
    this.city,
    this.country,
    this.checkIn,
    this.checkOut,
    this.adults = 2,
    this.children = 0,
  });

  /// Number of nights between check-in and check-out.
  int get nights {
    if (checkIn == null || checkOut == null) return 0;
    // Rounded so a DST shift can never turn 2 nights into 1.
    return (checkOut!.difference(checkIn!).inHours / 24).round();
  }

  int get totalGuests => adults + children;

  bool get hasLocation => city != null && city!.isNotEmpty;
  bool get hasDates => checkIn != null && checkOut != null;

  String get locationLabel => hasLocation ? city! : 'Search location';

  String get dateLabel {
    if (!hasDates) return 'Select dates';
    return '${_shortDate(checkIn!)} → ${_shortDate(checkOut!)}';
  }

  String get nightsLabel => nights == 1 ? '1 NIGHT' : '$nights NIGHTS';

  String get guestLabel {
    final String a = adults == 1 ? '1 Adult' : '$adults Adults';
    final String c = children == 1 ? '1 Child' : '$children Children';
    return '$a & $c';
  }

  /// Returns an error message, or null when the request is valid.
  String? validate() {
    if (!hasLocation) return 'Please select a location';
    if (checkIn == null) return 'Please select a check-in date';
    if (checkOut == null) return 'Please select a check-out date';
    if (nights < 1) return 'Check-out must be after check-in';
    if (adults < 1) return 'At least 1 adult is required';
    return null;
  }

  static String _shortDate(DateTime d) => '${d.day} ${monthShort(d.month)}';

  static String monthShort(int month) => const [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ][month - 1];

  static String fullDate(DateTime d) =>
      '${d.day} ${monthShort(d.month)} ${d.year}';

  static String weekdayShort(int weekday) => const [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][weekday - 1];

  /// 11 Sep '26, Fri
  static String heroDate(DateTime d) {
    final String yy = (d.year % 100).toString().padLeft(2, '0');
    return "${d.day} ${monthShort(d.month)} '$yy, ${weekdayShort(d.weekday)}";
  }
}
