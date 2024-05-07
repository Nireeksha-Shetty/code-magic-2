import 'package:flutter/material.dart';
import 'package:transit_ride_app/utils/formatters/formatters.dart';

extension TimeUtils on TimeOfDay {
  TimeOfDay? toTimeOfDayFromString(String t) {
    String timeOnly = Formatters.formatTime(DateTime.tryParse(t));

    var parts = timeOnly.split(':');
    if (parts.length != 2) {
      return null;
    }

    int? hour = int.tryParse(parts[0]);
    int? minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      return null;
    }

    TimeOfDay tod = TimeOfDay(
      hour: hour,
      minute: minute,
    );

    return tod;
  }

  bool isBefore(TimeOfDay tod) {
    double t1 = (this.hour + this.minute / 60.0).toDouble();
    double t2 = (tod.hour + tod.minute / 60.0).toDouble();

    if (t2 <= t1) {
      return true;
    } else {
      return false;
    }
  }

  bool isAfter(TimeOfDay tod) {
    double t1 = (this.hour + this.minute / 60.0).toDouble();
    double t2 = (tod.hour + tod.minute / 60.0).toDouble();

    if (t2 > t1) {
      return true;
    } else {
      return false;
    }
  }

  double toDouble() {
    double d = this.hour + this.minute / 60.0;

    return d;
  }
}
