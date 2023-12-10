import 'package:intl/intl.dart';

String parseTimestamp(String timestamp) { // convertir a texto la fecha
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

  // DateTime parsedDateTime = DateTime.parse(timestamp);
  String formattedDateTime = DateFormat('dd MMM yyyy').format(dt);
  return formattedDateTime;
}