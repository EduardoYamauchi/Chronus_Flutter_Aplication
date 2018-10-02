import 'package:intl/intl.dart';

timeStampGenerator() {
  DateTime now = DateTime.now();
  var datestamp = DateFormat("yyyyMMdd'T'HHmmss");
  String currentDate = datestamp.format(now);
  return currentDate;
}
