import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DateTimeUtils {
  static Future<DateTime?> showDatePickerDialog(
    BuildContext context, {
    DateTime? initialDateValue,
    DateTime? firstDate,
    DateTime? lastDate,
    List<int>? banDate,
    DatePickerEntryMode? mode,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialEntryMode: mode ?? DatePickerEntryMode.calendar,
      locale: Get.locale,
      initialDate: initialDateValue ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1000),
      lastDate: lastDate ?? DateTime(3000),
      // selectableDayPredicate: (DateTime val){
      //   bool ban = true;
      //   if(banDate != null){
      //     banDate.forEach((element) {
      //       if(val.weekday == element)
      //         ban = false;
      //     });
      //   }
      //   return ban;
      // },
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            // splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            // accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: ColorResource.colorPrimary,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: ColorResource.white,
          ),
          child: child!,
        );
      },
    );
    return date;
  }

  static showTimePickerDialog(BuildContext context,
      {TimeOfDay? initialTimeValue}) async {
    TimeOfDay timeOfDay = await showTimePicker(
          initialTime: initialTimeValue ?? TimeOfDay.now(),
          context: context,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.grey,
                  splashColor: Colors.grey,
                  textTheme: TextTheme(
                    subtitle1: TextStyle(color: Colors.black),
                    button: TextStyle(color: Colors.black),
                  ),

                  // accentColor: Colors.white,
                  colorScheme: ColorScheme.light(
                    primary: ColorResource.colorPrimary,
                    primaryVariant: Colors.white,
                    secondaryVariant: Colors.black,
                    onSecondary: Colors.black,
                    onPrimary: ColorResource.white,
                    surface: ColorResource.white,
                    onSurface: Colors.black,
                    secondary: ColorResource.colorPrimary,
                  ),
                  dialogBackgroundColor: ColorResource.white,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                ),
              ),
            );
          },
        ) ??
        TimeOfDay.now();
    return timeOfDay;
  }
}
