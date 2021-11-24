import 'dart:io';

import 'package:base_pm2/commons/resource/color_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseLoading extends StatelessWidget {
  double? withSize;
  double? height;
  Color? color;
  bool? isWithContainer = true;

  BaseLoading({this.withSize, this.height, this.color, this.isWithContainer});

  @override
  Widget build(BuildContext context) {
    if (isWithContainer ?? true) {
      return Container(
        width: withSize ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height,
        color: color ?? Colors.white.withOpacity(0.6),
        child: Center(
          child: Platform.isAndroid
              ? const CircularProgressIndicator(
                  color: ColorResource.colorPrimary)
              : const CupertinoActivityIndicator(),
        ),
      );
    } else {
      return Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator(color: ColorResource.colorPrimary)
            : const CupertinoActivityIndicator(),
      );
    }
  }
}
