import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '';
    }

    if (phoneNumber.length != 10) {
      return phoneNumber;
    }

    String formatted = phoneNumber.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d+)'),
        (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");

    return formatted;
  }

  static String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MM/dd/yyyy');
    String s = formatter.format(date);

    return s;
  }
  static DateFormat jmFormat = DateFormat.jm();

  static String formatDateTimeJm(String date) {
    try {
      String replacedDate = date.replaceAll('Z', '');
      DateTime dateTime = DateTime.parse(replacedDate);
      String formatDate = jmFormat.format(dateTime);
      return formatDate;
    } catch (e) {
      return '';
    }
  }

  static DateFormat hourMinuteSecondLeadingZerosFormat = DateFormat('HH:mm:ss');
  // makes UpsertReservation endpoint happy
  static String format1900Time(DateTime date) {
    return '1900-01-01T'+hourMinuteSecondLeadingZerosFormat.format(date);
  }

  static DateFormat isoLocalFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  static String formatIsoLocal(DateTime date) {
    return isoLocalFormat.format(date);
  }

  static DateFormat urlDateFormat = DateFormat('yyyy-MM-dd');
  static String formatUrlDate(DateTime date) {
    return urlDateFormat.format(date);
  }

  static List<String> daySuffixes = ["0th",  "1st",  "2nd",  "3rd", "4th",
    "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th",
    "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd",
    "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"];

  static String formatTimeStr(String? timeStr) {
    if (timeStr == null) {
      return '';
    }
    try {
      return formatTime(DateTime.parse(timeStr));
    } catch (e) {
      return '';
    }
  }

  static String formatTime(
    DateTime? date, {
    bool twentyFourHourFormat = false,
  }) {
    if (date == null) {
      return '';
    }

    late DateFormat formatter;

    if (twentyFourHourFormat) {
      formatter = DateFormat.Hm();
    } else {
      formatter = DateFormat.jm();
    }

    String s = formatter.format(date);

    return s;
  }

  static bool validateEmail(String email) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
  }

  static TimeOfDay? toTimeOfDayFromString(String time) {
    String timeOnly = Formatters.formatTime(
      DateTime.tryParse(time),
      twentyFourHourFormat: true,
    );

    var parts = timeOnly.split(':');
    if (parts.length != 2) {
      return null;
    }

    int? hour = int.tryParse(parts[0]);
    int? minute = int.tryParse(parts[1].split(' ')[0]);

    if (hour == null || minute == null) {
      return null;
    }

    TimeOfDay tod = TimeOfDay(
      hour: hour,
      minute: minute,
    );

    return tod;
  }

  static TimeOfDay toTimeOfDay(DateTime time) {
    TimeOfDay tod = TimeOfDay.fromDateTime(time);
    return tod;
  }

  static double timeOfDayToDouble(TimeOfDay tod) {
    double d = tod.hour + tod.minute / 60.0;

    return d;
  }
}
