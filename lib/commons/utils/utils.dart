import 'dart:io';

import 'package:base_pm2/commons/resource/export_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class Utils {
  static Widget getSpaceView(
    double width,
    double height,
  ) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  static void getBackWithNumber(int number) {
    for (int i = 0; i < number; i++) {
      Get.back();
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Widget emptyData() {
    return Center(
      child: Text(
        'Không có dữ liệu',
        style: TextStyle(color: ColorResource.colorPrimary, fontSize: 15),
      ),
    );
  }

  static double getHeightStatusBar(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static void showToast(
    String message, {
    Color? colorBg,
    Color? colorText,
  }) {
    colorBg ??= ColorResource.grey;
    colorText ??= ColorResource.black;
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: colorBg,
      textColor: colorText,
      timeInSecForIosWeb: 10,
      fontSize: 16.0,
    );
  }

  static String isPhoneNumber({String s = ''}) {
    if (s.trim().isEmpty) {
      return 'Không được để trống';
    } else if (!RegExp(r'^0[0-9]{9,12}$').hasMatch(s)) {
      return 'Số điện thoại không đúng định dạng';
    } else {
      return '';
    }
  }

  static String isEmail({String s = ''}) {
    if (s.trim().isEmpty) {
      return 'Không được để trống';
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(s)) {
      return 'Email không đúng định dạng';
    } else {
      return '';
    }
  }

  static String isName({String s = ''}) {
    if (s.trim().isEmpty) {
      return 'Không được để trống';
    } else if (!(RegExp(r"^[\p{L} '-]*$",
            caseSensitive: false, unicode: true, dotAll: true)
        .hasMatch(s))) {
      return 'Tên không đúng định dạng';
    } else {
      return '';
    }
  }

  static String standardized(String s) {
    String standard = s.trim().replaceAll(RegExp('\\s+'), ' ');
    return standard;
  }

  static String standardizedName(String s) {
    String standard = s.trim().replaceAll(RegExp('\\s+'), ' ');
    final List<String> temp = standard.split(" ");
    StringBuffer buffer = StringBuffer();
    if (temp.length > 1) {
      for (int i = 0; i < temp.length; i++) {
        buffer.write(
            temp[i][0].toUpperCase() + temp[i].toLowerCase().substring(1));
        if (i < temp.length - 1) buffer.write(" ");
      }
    } else {
      for (int i = 0; i < s.length; i++) {
        if (i == 0) {
          buffer.write(s[i].toUpperCase());
        } else {
          buffer.write(s[i].toLowerCase());
        }
      }
    }
    return buffer.toString();
  }

  static String trimAll(String s) {
    return s.trim().replaceAll(RegExp('\\s'), '');
  }

  static String deleteDot(String s) {
    if (s.contains('.')) {
      return s.trim().replaceAll(RegExp('\\.'), '');
    }
    return s.trim();
  }

  static String deleteSpace(String s) {
    if (s.contains(' ')) {
      return s.trim().replaceAll(RegExp(' '), '');
    }
    return s.trim();
  }

  static String? addDot(String? s) {
    String sTmp = '';
    if (s != null) {
      if (s.length > 1) {
        sTmp += s[0];
        for (int i = 1; i < s.length; i++) {
          if (i % 3 == 0) {
            if (i == s.length - 1) {
              sTmp += s[i];
            } else
              sTmp += '${s[i]}.';
          } else {
            sTmp += s[i];
          }
        }
        return sTmp;
      } else
        return null;
    } else
      return null;
  }

  static String? addSpace(String? s) {
    String sTmp = '';
    if (s != null) {
      if (s.length > 1) {
        sTmp += s[0];
        for (int i = 1; i < s.length; i++) {
          if (i % 3 == 0) {
            if (i == s.length - 1) {
              sTmp += s[i];
            } else
              sTmp += '${s[i]} ';
          } else {
            sTmp += s[i];
          }
        }
        return sTmp;
      } else
        return null;
    } else
      return null;
  }

  static bool isNotNullEmpty(String? s) {
    if (s != null) {
      if (s.trim().isNotEmpty) {
        return true;
      } else
        return false;
    } else
      return false;
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static Widget defaultAvatar() {
    return Container();
  }
}
