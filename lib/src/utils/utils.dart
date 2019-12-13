int differenceDates(String minDate,{ String maxDate = '' }) {
  DateTime now = maxDate == '' ? DateTime.now() : maxDate;
  DateTime myDatetime = DateTime.parse(minDate);
  Duration difference = now.difference(myDatetime);
  return difference.inDays;
}  