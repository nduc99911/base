import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TimeUtils {
  static String dateFormat = "dd/MM/yyyy";
  static String dateFormat2 = "yyyy-MM-dd";
  static String dateFormat3 = "dd,MMM,yyyy";
  static String dayFormat = "dd";

  static String monthFormat = "MM";
  static String dayMonthFormat = "dd/MM";
  static String monthYearFormat = "MM-yyyy";
  static String monthYear = "MM/yyyy";

  static String timeFormat = "HH:mm";
  static String hourFormat = "hh:mm a";
  static String timeDayYearFormat = "HH:mm dd-MM-yy";
  static String timeDayYearFormat2 = "HH:mm, dd/MM/yyyy";

  static String dateHourFormat = "dd/MM/yyyy  HH:mm";
  static String locateDatetime = "yyyy-MM-ddTHH:mm:ss";
  static String locateDatetime2 = "dd/MM/yyyy HH:mm:ss";
  static String locateDatetime3 = "yyyy-MM-dd HH:mm:ss.SSS";
  static String locateDatetimeMinute = "yyyy-MM-ddTHH:mm";
  static String yearFormat = "yyyy";

  static DateTime getFirstDateOfMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    return firstDayOfMonth;
  }

  static DateTime getLastDateOfMonth() {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth;
  }

  static DateTime convertStringToDate(String data, String formatFrom) {
    return new DateFormat(formatFrom).parse(data);
  }

  static String convertTimeToFormat(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }

  static String convertTimeToFormated(
    String data,
    String? formatFrom,
    String? formatTo,
  ) {
    try {
      DateTime dateTime =
          new DateFormat(formatFrom ?? TimeUtils.locateDatetime2).parse(data);
      String formattedDate =
          DateFormat(formatTo ?? TimeUtils.dateFormat).format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static String convertDateTimeToFormat(DateTime time, String formatTo) {
    String formattedDate = DateFormat(formatTo).format(time);
    return formattedDate;
  }

  static String getFirstDayOfMonth(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    return convertDateTimeToFormat(firstDayOfMonth, formatTo);
  }

  static String getLastDayOfMonth(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
    return convertDateTimeToFormat(lastDayOfMonth, formatTo);
  }

  static String getFirstTimeOfDay() {
    DateTime now = DateTime.now();
    String firstTimeOfDay =
        "${(now.day.toString().length > 1) ? now.day : "0${now.day}"}-"
        "${(now.month.toString().length > 1) ? now.month : "0${now.month}"}-"
        "${now.year} 00:00";
    return firstTimeOfDay;
  }

  static DateTime getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
    return firstDayOfWeek;
  }

  static String getYesterday(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime yesterday = new DateTime(
        now.year, now.month, now.day - 1, now.hour, now.minute, now.second);
    return convertDateTimeToFormat(yesterday, formatTo);
  }

  static String getDateTime(DateTime date, TimeOfDay time) {
    String dateStr = convertDateTimeToFormat(date, "dd/MM/yyyy");
    String timeStr = "${time.hour}:${time.minute}:00";
    return "$dateStr $timeStr";
  }

  static weekday(DateTime date) {
    int index = date.weekday;
    String name = '';
    switch (index) {
      case 1:
        name = 'Thứ hai';
        break;
      case 2:
        name = 'Thứ ba';
        break;
      case 3:
        name = 'Thứ tư';
        break;
      case 4:
        name = 'Thứ năm';
        break;
      case 5:
        name = 'Thứ sáu';
        break;
      case 6:
        name = 'Thứ bảy';
        break;
      case 7:
        name = 'Chủ nhật';
        break;
      default:
        name = '';
        break;
    }
    return name;
  }

  static getMonthTwoLanguage({int? month}) {
    var mMonth = {
      'vi': {
        1: 'Tháng 1',
        2: 'Tháng 2',
        3: 'Tháng 3',
        4: 'Tháng 4',
        5: 'Tháng 5',
        6: 'Tháng 6',
        7: 'Tháng 7',
        8: 'Tháng 8',
        9: 'Tháng 9',
        10: 'Tháng 10',
        11: 'Tháng 11',
        12: 'Tháng 12',
      },
      'en': {
        1: 'January',
        2: 'February',
        3: 'March ',
        4: 'April',
        5: 'May',
        6: 'June',
        7: 'July',
        8: 'August',
        9: 'September',
        10: 'October',
        11: 'November',
        12: 'December',
      },
    };
    return mMonth['vi']![month];
  }

  static timeOfDay(DateTime date) {
    int index = date.hour;
    Map<String, Map<String, String>> mapMonth = HashMap();
    mapMonth['month'] = {'vi_VN': index < 12 ? 'SA' : 'CH'};
    String timeOfDay = '';
    mapMonth.entries.forEach((element) {
      element.value.entries.forEach((element) {
        if (element.key == Get.locale.toString()) {
          if (date.hour < 10) if (date.minute < 10) {
            timeOfDay = '0${date.hour}:0${date.minute} ${element.value}';
          } else {
            timeOfDay = '0${date.hour}:${date.minute} ${element.value}';
          }
          else {
            if (date.minute < 10) {
              timeOfDay = '${date.hour}:0${date.minute} ${element.value}';
            } else {
              timeOfDay = '${date.hour}:${date.minute} ${element.value}';
            }
          }
        } else {
          timeOfDay = TimeUtils.convertDateTimeToFormat(date, hourFormat);
        }
      });
    });
    return timeOfDay;
  }

  static DateTime utc({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    DateTime d = DateTime.now();
    return DateTime(year ?? d.year, month ?? d.month, day ?? d.day,
        hour ?? d.hour, minute ?? d.minute, second ?? d.second);
  }

  /*
   * @author TaiDM
   * @date 21-09-2021 08:45 AM
   * @update Hàm này có tác dụng so sánh 2 thời gian (hour, minute) nếu thời [date] > [now] => 1;[date] == [now] => 0;[date] < [now] => -1;
   */
  static int compareTimeWithNow({DateTime? date, DateTime? now}) {
    now = now ?? DateTime.now();
    if (date!.hour > now.hour) {
      return 1;
    } else if (date.hour == now.hour) {
      if (date.minute > now.minute) {
        return 1;
      } else if (date.minute == now.minute) {
        return 0;
      } else
        return -1;
    } else
      return -1;
  }

  /*
   * @author TaiDM
   * @date 21-09-2021 08:53 AM
   * @update Hàm này có tác dụng so sánh 2 thời gian (year, month, day) nếu thời [date] > [now] => 1;[date] == [now] => 0;[date] < [now] => -1;
   */
  static int compareDateWithNow({required DateTime d1, required DateTime d2}) {
    if (d1.year > d2.year) {
      return 1;
    } else if (d1.year == d2.year) {
      if (d1.month > d2.month) {
        return 1;
      } else if (d1.month == d2.month) {
        if (d1.day > d2.day) {
          return 1;
        } else if (d1.day == d2.day) {
          return 0;
        } else
          return -1;
      } else
        return -1;
    } else
      return -1;
  }

  static int compareDateTime({DateTime? date, DateTime? now}) {
    now = now ?? DateTime.now();
    if (date!.year > now.year) {
      return 1;
    } else if (date.year == now.year) {
      if (date.month > now.month) {
        return 1;
      } else if (date.month == now.month) {
        if (date.day > now.day) {
          return 1;
        } else if (date.day == now.day) {
          if (date.hour > now.hour) {
            return 1;
          } else if (date.hour == now.hour) {
            if (date.minute > now.minute) {
              return 1;
            } else if (date.minute == now.minute) {
              return 0;
            } else
              return -1;
          } else
            return -1;
        } else
          return -1;
      } else
        return -1;
    } else
      return -1;
  }

  //--------------------- lấy ra các ngày đầu tiên và cuối cùng của một tuần (cũng có thể lấy được các ngày trong tuần)
  static List<DateTime> getDayOfWeek({DateTime? dateTime}) {
    dateTime = dateTime ?? DateTime.now();
    List<DateTime> dateTimeCheck = [];
    DateTime monday =
        dateTime.subtract(Duration(days: DateTime.now().weekday - 1));
    DateTime sunday = DateTime(monday.year, monday.month, monday.day + 6);
    for (int i = 0; i < 7; i++) {
      dateTimeCheck.add(DateTime(monday.year, monday.month, monday.day + i));
    }

    return dateTimeCheck;
  }
}
