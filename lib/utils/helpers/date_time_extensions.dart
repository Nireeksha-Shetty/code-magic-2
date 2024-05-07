
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {

  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  DateTime next(int day) {
    return DateTime(
      this.year,
      this.month,
      this.day + (day == weekday ? 7 : (day - weekday) % DateTime.daysPerWeek),
    );
  }

  DateTime previous(int day) {
    return DateTime(
      this.year,
      this.month,
      this.day - (day == weekday ? 7 : (weekday - day) % DateTime.daysPerWeek),
    );
  }

  DateTime thisOrPrevious(int day) {
    return DateTime(
      this.year,
      this.month,
      this.day - (day == weekday ? 0 : (weekday - day) % DateTime.daysPerWeek),
    );
  }

  int weekOfMonth() {
    // return min((this.day / 7).ceil(), 4);
    return (this.day / 7).ceil();
  }

  static DateFormat _weekdayAbbrFormat = DateFormat("E");

  String weekdayAbbr() {
    return _weekdayAbbrFormat.format(this);
  }

  bool isOnOrBefore(DateTime other) {
    return !this.isAfter(other);
  }

  bool isOnOrAfter(DateTime other) {
    return !this.isBefore(other);
  }

  bool betweenInclusive({required DateTime from, required DateTime to}) {
    return this.isOnOrAfter(from) && this.isOnOrBefore(to);
  }

  DateTime subtractDays(int days) {
    return DateTime(this.year, this.month, this.day - days);
  }

  int daysInMonth() {
    return DateUtils.getDaysInMonth(this.year, this.month);
  }

  /// adjusts to last day of future month if future month has fewer days.
  /// example: March_31.addMonths(1) returns April_30.
  /// optionally override day with [dayOfMonth].
  DateTime addMonths({int months = 1, int? dayOfMonth}) {
    int day = dayOfMonth ?? this.day;
    if (day < 1) {
      day = 1;
    }
    if (months < 1) {
      months = 1;
    }
    if (day > 28) {
      int lastDayOfFutureMonth =
          this.copyWith(day: 1, month: this.month + months).daysInMonth();
      if (lastDayOfFutureMonth < day) {
        day = lastDayOfFutureMonth;
      }
    }
    return this.copyWith(day: day, month: this.month + months);
  }

  /// [weekdayIndex] should be zero index value for week starting with Monday
  /// if [weekdayIndex] is not supplied, the weekday value for the
  /// DateTime instance will be used.
  List<int> daysOfWeekdayInMonth({int? weekdayIndex}) {
    int dayOfWeekIndexAssured = weekdayIndex ?? this.weekday - 1;
    // find DayOfWeek of the first day of the month
    DateTime firstDayOfMonth = this.day == 1 ? this : this.copyWith(day: 1);
    int firstDayOfMonthDayOfWeekIndex = firstDayOfMonth.weekday - 1;
    // find the first occurrence of the wanted day of week.
    // (first day of month may not be an instance of the wanted day's of week)
    int offsetFromFirstDayOfMonth = 0;
    while (true) {
      if ((firstDayOfMonthDayOfWeekIndex + offsetFromFirstDayOfMonth) % 7 ==
          dayOfWeekIndexAssured) {
        break;
      }
      offsetFromFirstDayOfMonth++;
    }
    // offset zero based, days in month, so need to adjust by 1
    int dayOfFirstOccurrence = offsetFromFirstDayOfMonth + 1;
    // find the remaining occurrences in the month
    List<int> daysOfWeekInMonth = [];
    daysOfWeekInMonth.add(dayOfFirstOccurrence);
    int nextDayOfOccurrence = dayOfFirstOccurrence;
    int daysInMonth = this.daysInMonth();
    while (nextDayOfOccurrence + 7 <= daysInMonth) {
      nextDayOfOccurrence += 7;
      daysOfWeekInMonth.add(nextDayOfOccurrence);
    }
    return daysOfWeekInMonth;
  }

}